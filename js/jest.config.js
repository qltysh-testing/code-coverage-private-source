module.exports = {
  testEnvironment: 'node',
  coverageDirectory: 'coverage',
  collectCoverageFrom: [
    'src/**/*.js',
    '!src/**/*.test.js'
  ],
  coverageReporters: ['lcov', 'text', 'text-summary'],
  testMatch: ['**/tests/**/*.test.js']
};
