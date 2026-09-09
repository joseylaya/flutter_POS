const loginForm = document.querySelector('#login-form');
const pinForm = document.querySelector('#pin-form');
const result = document.querySelector('#result');
const status = document.querySelector('#status');
const logout = document.querySelector('#logout');

function showAuthenticated(authenticated) {
  loginForm.hidden = authenticated;
  pinForm.hidden = !authenticated;
  logout.hidden = !authenticated;
  if (!authenticated) result.hidden = true;
}

async function request(path, options = {}) {
  const response = await fetch(path, {
    ...options,
    headers: { 'Content-Type': 'application/json', ...(options.headers || {}) },
  });
  const body = await response.json();
  if (!response.ok) throw new Error(body.error || 'Request failed.');
  return body;
}

loginForm.addEventListener('submit', async (event) => {
  event.preventDefault();
  status.textContent = '';
  const button = loginForm.querySelector('button');
  button.disabled = true;
  try {
    await request('/api/login', {
      method: 'POST',
      body: JSON.stringify({
        username: document.querySelector('#username').value,
        password: document.querySelector('#password').value,
      }),
    });
    loginForm.reset();
    showAuthenticated(true);
    document.querySelector('#request-pin').focus();
  } catch (error) {
    status.textContent = error.message;
  } finally {
    button.disabled = false;
  }
});

pinForm.addEventListener('submit', async (event) => {
  event.preventDefault();
  status.textContent = '';
  result.hidden = true;
  const button = pinForm.querySelector('button');
  button.disabled = true;
  try {
    const body = await request('/api/generate', {
      method: 'POST',
      body: JSON.stringify({ requestPin: document.querySelector('#request-pin').value }),
    });
    document.querySelector('#activation-pin').textContent = body.activationPin;
    result.hidden = false;
  } catch (error) {
    if (error.message === 'Sign in to continue.') showAuthenticated(false);
    status.textContent = error.message;
  } finally {
    button.disabled = false;
  }
});

document.querySelector('#copy').addEventListener('click', async () => {
  await navigator.clipboard.writeText(document.querySelector('#activation-pin').textContent);
  status.textContent = 'Activation code copied.';
});

logout.addEventListener('click', async () => {
  await request('/api/logout', { method: 'POST', body: '{}' });
  status.textContent = '';
  showAuthenticated(false);
});

request('/api/session')
  .then(() => showAuthenticated(true))
  .catch(() => showAuthenticated(false));
