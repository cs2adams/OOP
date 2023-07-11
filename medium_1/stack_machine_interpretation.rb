class EmptyStackError < StandardError; end

class InvalidTokenError < StandardError; end

class Minilang
  def initialize(program)
    @program = program
    @register = 0
    @stack = []
  end

  def eval(args = {})
    
    format(program, args).split.each do |command|
      begin
        if integer?(command)
          n(command.to_i)
        else
          send(command.downcase)
        end
      rescue NoMethodError
        raise InvalidTokenError, "Invalid Token: #{command}"
      end
    end
  rescue StandardError => e
    puts e.message
  end

  private

  attr_reader :stack, :program
  attr_accessor :register

  def integer?(command)
    command == command.to_i.to_s
  end

  def n(value)
    self.register = value
  end

  def print
    puts register
  end

  def push
    stack << register
  end

  def add
    raise EmptyStackError, "Empty stack!" if stack.empty?
    self.register += stack.pop
  end

  def sub
    raise EmptyStackError, "Empty stack!" if stack.empty?
    self.register -= stack.pop
  end

  def mult
    raise EmptyStackError, "Empty stack!" if stack.empty?
    self.register *= stack.pop
  end

  def div
    raise EmptyStackError, "Empty stack!" if stack.empty?
    self.register /= stack.pop
  end

  def mod
    raise EmptyStackError, "Empty stack!" if stack.empty?
    self.register %= stack.pop
  end

  def pop
    raise EmptyStackError, "Empty stack!" if stack.empty?
    self.register = stack.pop
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)

CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100)
# 212
minilang.eval(degrees_c: 0)
# 32
minilang.eval(degrees_c: -40)
# -40

FARENHEIT_TO_CENTRIGRADE = 
  '9 PUSH 5 PUSH 32 PUSH %<degrees_f>d SUB MULT DIV PRINT'
minilang = Minilang.new(FARENHEIT_TO_CENTRIGRADE)
minilang.eval(degrees_f: 212)
minilang.eval(degrees_f: 32)
minilang.eval(degrees_f: -40)

MPH_TO_KPH = '3 PUSH 5 PUSH %<mph>d MULT DIV PRINT'
minilang = Minilang.new(MPH_TO_KPH)
minilang.eval(mph: 3)
minilang.eval(mph: 60)
minilang.eval(mph: 45)

AREA_OF_RECTANGLE = '%<width>d PUSH %<height>d MULT PRINT'
minilang = Minilang.new(AREA_OF_RECTANGLE)
minilang.eval(width: 5, height: 10)
minilang.eval(width: 2, height: 3)