const button = document.getElementById('action-button');
const message = document.getElementById('message');

button.addEventListener('click', () => {
  const now = new Date().toLocaleString();
  message.textContent = `This frontend was built with Terraform, deployed as a static website, and rendered in your browser at ${now}.`;
});
