const crypto = require('node:crypto');

const COOKIE_NAME = 'jmpos_verifier_session';

function requiredEnv(name) {
  const value = process.env[name];
  if (!value) throw new Error(`Missing ${name}`);
  return value;
}

function safeEqual(left, right) {
  const a = Buffer.from(String(left));
  const b = Buffer.from(String(right));
  return a.length === b.length && crypto.timingSafeEqual(a, b);
}

function signature(payload) {
  return crypto
    .createHmac('sha256', requiredEnv('SESSION_SECRET'))
    .update(payload)
    .digest('base64url');
}

function createSession(username) {
  const payload = Buffer.from(
    JSON.stringify({ username, expiresAt: Date.now() + 15 * 60 * 1000 }),
  ).toString('base64url');
  return `${payload}.${signature(payload)}`;
}

function sessionUser(req) {
  const cookie = String(req.headers.cookie || '')
    .split(';')
    .map((part) => part.trim())
    .find((part) => part.startsWith(`${COOKIE_NAME}=`));
  if (!cookie) return null;
  const token = cookie.slice(COOKIE_NAME.length + 1);
  const separator = token.lastIndexOf('.');
  if (separator < 1) return null;
  const payload = token.slice(0, separator);
  const suppliedSignature = token.slice(separator + 1);
  if (!safeEqual(suppliedSignature, signature(payload))) return null;
  try {
    const data = JSON.parse(Buffer.from(payload, 'base64url').toString());
    if (data.expiresAt <= Date.now()) return null;
    if (!safeEqual(data.username, requiredEnv('ADMIN_USERNAME'))) return null;
    return data.username;
  } catch (_) {
    return null;
  }
}

function setSessionCookie(res, token) {
  res.setHeader(
    'Set-Cookie',
    `${COOKIE_NAME}=${token}; HttpOnly; Secure; SameSite=Strict; Path=/; Max-Age=900`,
  );
}

function clearSessionCookie(res) {
  res.setHeader(
    'Set-Cookie',
    `${COOKIE_NAME}=; HttpOnly; Secure; SameSite=Strict; Path=/; Max-Age=0`,
  );
}

function noStore(res) {
  res.setHeader('Cache-Control', 'no-store, max-age=0');
}

module.exports = {
  clearSessionCookie,
  createSession,
  noStore,
  requiredEnv,
  safeEqual,
  sessionUser,
  setSessionCookie,
};
