const { capitalize, reverse, isPalindrome, countWords } = require('../src/stringUtils');

describe('String Utilities', () => {
  describe('capitalize', () => {
    test('should capitalize first letter of lowercase string', () => {
      expect(capitalize('hello')).toBe('Hello');
    });

    test('should handle already capitalized string', () => {
      expect(capitalize('Hello')).toBe('Hello');
    });

    test('should handle empty string', () => {
      expect(capitalize('')).toBe('');
    });
  });

  describe('reverse', () => {
    test('should reverse a string', () => {
      expect(reverse('hello')).toBe('olleh');
    });

    test('should handle single character', () => {
      expect(reverse('a')).toBe('a');
    });
  });

  describe('isPalindrome', () => {
    test('should identify palindrome', () => {
      expect(isPalindrome('racecar')).toBe(true);
    });

    test('should identify non-palindrome', () => {
      expect(isPalindrome('hello')).toBe(false);
    });

    test('should handle empty string', () => {
      expect(isPalindrome('')).toBe(true);
    });
  });

  describe('countWords', () => {
    test('should count words in sentence', () => {
      expect(countWords('hello world test')).toBe(3);
    });

    test('should handle single word', () => {
      expect(countWords('hello')).toBe(1);
    });

    test('should handle empty string', () => {
      expect(countWords('')).toBe(0);
    });
  });
});
