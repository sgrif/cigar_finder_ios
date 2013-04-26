module Delegation
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def delegate(*args)
      options = args.pop
      args.each do |method_name|
        define_method(method_name) do |*params, &block|
          target = send(options[:to])
          target.send(method_name, *params, &block)
        end
      end
    end
  end
end