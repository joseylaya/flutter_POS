import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  final requestPin = _option(arguments, 'request')?.trim();
  final secretPath =
      _option(arguments, 'secret') ?? '.jmpos-license/pin_secret.hex';
  if (requestPin == null || !RegExp(r'^\d{6}$').hasMatch(requestPin)) {
    stderr.writeln(
      'Usage: dart run tool/generate_activation.dart --request 123456 '
      '[--secret path]',
    );
    exitCode = 64;
    return;
  }
  final secretFile = File(secretPath);
  if (!secretFile.existsSync()) {
    stderr.writeln('Activation secret not found at $secretPath.');
    exitCode = 66;
    return;
  }
  final secret = (await secretFile.readAsString()).trim();
  if (!RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(secret)) {
    stderr.writeln('Activation secret is invalid.');
    exitCode = 65;
    return;
  }
  final process = await Process.start('openssl', [
    'dgst',
    '-sha256',
    '-mac',
    'HMAC',
    '-macopt',
    'hexkey:$secret',
  ]);
  process.stdin.write(requestPin);
  await process.stdin.close();
  final output = await process.stdout.transform(utf8.decoder).join();
  final error = await process.stderr.transform(utf8.decoder).join();
  final result = await process.exitCode;
  if (result != 0) {
    stderr.writeln('Unable to generate PIN: ${error.trim()}');
    exitCode = result;
    return;
  }
  final match = RegExp(r'= ([a-fA-F0-9]{64})').firstMatch(output);
  if (match == null) {
    stderr.writeln('OpenSSL returned an unexpected result.');
    exitCode = 70;
    return;
  }
  final digest = match.group(1)!;
  final value = int.parse(digest.substring(0, 8), radix: 16) % 1000000;
  stdout.writeln(value.toString().padLeft(6, '0'));
}

String? _option(List<String> arguments, String name) {
  final index = arguments.indexOf('--$name');
  if (index == -1 || index + 1 >= arguments.length) return null;
  return arguments[index + 1];
}
