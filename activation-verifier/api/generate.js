const { noStore, requiredEnv, sessionUser } = require('../lib/auth');
const { generateActivationPin } = require('../lib/pin');

module.exports = (req, res) => {
  noStore(res);
  if (req.method !== 'POST') {
    res.setHeader('Allow', 'POST');
    return res.status(405).json({ error: 'Method not allowed.' });
  }
  if (!sessionUser(req)) {
    return res.status(401).json({ error: 'Sign in to continue.' });
  }
  try {
    const requestPin = String(req.body?.requestPin || '').trim();
    const activationPin = generateActivationPin(
      requestPin,
      requiredEnv('ACTIVATION_SECRET_HEX'),
    );
    return res.status(200).json({ activationPin });
  } catch (error) {
    return res.status(400).json({ error: error.message });
  }
};
