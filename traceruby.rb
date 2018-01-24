require 'binding_of_caller'
require 'pp'

def Record
  stream = File.open("recorded.json", 'w')
  tp = nil
  Object.new.instance_eval do
    tp = TracePoint.new :call, :c_call do |tp|
      callers = tp.binding.callers
      callers = callers.drop_while { |c| c.receiver != self }
      callers = callers.drop_while { |c| c.receiver == self }
      callers = callers.drop(1)
      sender  = callers.first.receiver

      stream.print '['
      stream.print sender.class.to_s.inspect
      stream.print ','
      stream.print tp.method_id.to_s.inspect
      stream.print ','
      stream.print tp.defined_class.to_s.inspect
      stream.print ']'
      stream.print "\n"
    end
    tp.enable
    yield
  end
ensure
  tp&.disable
  stream.close unless stream.closed?
end
