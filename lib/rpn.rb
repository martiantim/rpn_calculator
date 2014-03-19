class Op
  attr_reader :a, :b

  def initialize(a, b)
    @a = a
    @b = b
  end
end

class OpPlus < Op
  def evaluate
    @a.evaluate + @b.evaluate
  end
end

class OpMinus < Op
  def evaluate
    @b.evaluate - @a.evaluate
  end
end

class OpDivide < Op
  def evaluate
    @b.evaluate / @a.evaluate
  end
end

class OpMultiply < Op
  def evaluate
    @b.evaluate * @a.evaluate
  end
end

class RpnNumber
  def initialize(num)
    @num = num
  end

  def evaluate
    @num
  end
end

class RPN
  OPERATORS = {
    '+' => OpPlus,
    '-' => OpMinus,
    '/' => OpDivide,
    '*' => OpMultiply
  }

  def initialize(str = "")
    @str = str
  end

  def parse
    stack = []
    @str.split(' ').each do |a|
      op = parse_symbol(a)
      if !op.is_a?(Numeric)
        a = stack.pop
        b = stack.pop
        raise ArgumentError.new("not enough arguments") if !a || !b
        stack.push(op.new(a, b))
      else
        stack.push(RpnNumber.new(op))
      end
    end

    puts "Warning: extra ops" if stack.length > 1
    stack.pop
  end

  def parse_symbol(str)
    OPERATORS.detect do |op, klass|
      if str == op
        return klass
      end
    end

    sign = 1
    if str[0] == '-'
      sign = -1
      str = str[1..-1]
    end
    num = 0
    while str.length > 0
      i = str[0].ord - 48
      raise ArgumentError, "invalid number" if i < 0 || i > 9
      num = num * 10 + i
      str = str[1..-1]
    end

    sign * num
  end
end

begin
  puts RPN.new(ARGV[0]).parse.evaluate
rescue ArgumentError => e
  puts e.message
end