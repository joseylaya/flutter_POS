const test = require('node:test');
const assert = require('node:assert/strict');

process.env.ADMIN_USERNAME = 'test-admin';
process.env.ADMIN_PASSWORD = 'test-password-that-is-long';
process.env.SESSION_SECRET = 'test-session-secret-that-is-at-least-32-characters';

const { createSession, sessionUser } = require('../lib/auth');

test('accepts a valid signed session and rejects tampering', () => {
  const token = createSession('test-admin');
  const req = { headers: { cookie: `jmpos_verifier_session=${token}` } };
  assert.equal(sessionUser(req), 'test-admin');

  req.headers.cookie = `jmpos_verifier_session=${token.slice(0, -1)}x`;
  assert.equal(sessionUser(req), null);
});

test('rejects missing sessions', () => {
  assert.equal(sessionUser({ headers: {} }), null);
});
