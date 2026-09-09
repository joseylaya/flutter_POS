const test = require('node:test');
const assert = require('node:assert/strict');
const { generateActivationPin } = require('../lib/pin');

const secret = '0'.repeat(64);

test('matches the Android and Dart activation algorithm', () => {
  assert.equal(generateActivationPin('123456', secret), '462540');
  assert.equal(generateActivationPin('000000', secret), '168539');
});

test('rejects malformed request PINs and secrets', () => {
  assert.throws(() => generateActivationPin('12345', secret), /six-digit/);
  assert.throws(() => generateActivationPin('abcdef', secret), /six-digit/);
  assert.throws(() => generateActivationPin('123456', 'bad'), /not configured/);
});
