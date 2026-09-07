import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ActivationStatus {
  const ActivationStatus({
    required this.activated,
    required this.installationId,
    this.businessName,
    this.issuedAt,
    this.requestPin,
  });

  final bool activated;
  final String installationId;
  final String? businessName;
  final String? issuedAt;
  final String? requestPin;

  factory ActivationStatus.fromMap(Map<Object?, Object?> value) =>
      ActivationStatus(
        activated: value['activated'] == true,
        installationId: value['installationId'] as String? ?? '',
        businessName: value['businessName'] as String?,
        issuedAt: value['issuedAt'] as String?,
        requestPin: value['requestPin'] as String?,
      );
}

class ActivationService {
  static const _channel = MethodChannel('com.jmpos.jm_pos/activation');

  bool get isRequired =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  Future<ActivationStatus> status() async {
    if (!isRequired) {
      return const ActivationStatus(
        activated: true,
        installationId: 'DEVELOPMENT-BUILD',
        businessName: 'JmPOS Development',
      );
    }
    final result = await _channel.invokeMapMethod<Object?, Object?>(
      'getActivationStatus',
    );
    if (result == null) throw StateError('Activation service unavailable.');
    return ActivationStatus.fromMap(result);
  }

  Future<ActivationStatus> activate(String pin) async {
    final result = await _channel.invokeMapMethod<Object?, Object?>(
      'activate',
      {'pin': pin},
    );
    if (result == null) throw StateError('Activation service unavailable.');
    return ActivationStatus.fromMap(result);
  }
}
