const crypto = require('node:crypto');

function generateActivationPin(requestPin, secretHex) {
  if (!/^\d{6}$/.test(requestPin)) {
    throw new Error('Enter the six-digit request PIN shown on the mobile app.');
  }
  if (!/^[a-f\d]{64}$/i.test(secretHex)) {
    throw new Error('The activation service is not configured correctly.');
  }
  const digest = crypto
    .createHmac('sha256', Buffer.from(secretHex, 'hex'))
    .update(requestPin)
    .digest();
  const value = digest.readUInt32BE(0) % 1000000;
  return String(value).padStart(6, '0');
}

module.exports = { generateActivationPin };
