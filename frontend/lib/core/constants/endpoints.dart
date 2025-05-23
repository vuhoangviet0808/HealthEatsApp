const baseUrl = String.fromEnvironment(
  'BASE_URL',
  defaultValue: 'http://10.0.2.2:9000',
);

const loginUrl    = '$baseUrl/auth/login';
const registerUrl = '$baseUrl/auth/register';
