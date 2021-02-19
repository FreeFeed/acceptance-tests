function getRandomInRange(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function randomUser() {
  const max = getRandomInRange(7, 15);
  const num = getRandomInRange(1, max);
  const unimatrix = getRandomInRange(1000, 99999);

  const id = Date.now();

  return {
    username: `borg${id}`,
    screenName: `${num} of ${max}, unimatrix ${unimatrix}`,
    description:
      'We are the Borg. Lower your shields and surrender your ships. We will add your biological and technological distinctiveness to our own. Your culture will adapt to service us. Resistance is futile.',
    password: `${Math.random().toString(36)}${Math.random().toString(36)}`,
    email: `borg${id}@freefeed.net`,
  };
}

module.exports = randomUser;
