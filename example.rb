class A
  def initialize(b)
    @b = b
  end

  def doit_a
    @b.doit_b
  end
end

class B
  def initialize(n)
    @n = n
  end

  def doit_b
    @n + @n
  end
end

require_relative 'traceruby'
a = A.new B.new 12
Record { a.doit_a }
