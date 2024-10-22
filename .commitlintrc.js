module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'scope-enum': [2, 'always', [
        'hosts',
        'nixos',
        'kubernetes',
        'monitoring',
        'dotnet',
        'java',
        'cloud',
        'ui',
        'media',
        'messengers',
        'python',
        'repo'
      ]
    ],
    'body-max-line-length': [2, 'always', 140]
  }
};
