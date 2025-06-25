module.exports = {
  root: true,
  env: {
    es17: true,
    node: true,
  },
  extends: [
    "eslint:recommended",
    "google",
  ],
  rules: {
    quotes: ["error", "double"],
  },
  parserOptions: {
    "parser": "babel-eslint",
  },
};
