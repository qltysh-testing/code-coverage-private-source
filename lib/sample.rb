# frozen_string_literal: true

class Sample
  class << self
    def add(a, b)
      a + b
    end

    def subtract(a, b)
      a - b
    end

    def multiply(a, b)
      a * b
    end

    def divide(a, b)
      if b.zero?
        raise ZeroDivisionError, "Division by zero is not allowed."
      else
        a / b
      end
    end

    def modulo(a, b)
      if b.zero?
        raise ZeroDivisionError, "Modulo by zero is not allowed."
      else
        a % b
      end
    end

    def main()
      puts("Hello, world!");

      puts("3 + 2 = #{add(3, 2)}");
      puts("5 - 3 = #{subtract(5, 3)}");
      puts("4 * 3 = #{multiply(4, 3)}");
    end
  end
end
