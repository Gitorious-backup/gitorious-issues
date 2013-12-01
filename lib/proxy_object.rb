class ProxyObject < Module
  attr_reader :name

  def initialize(name)
    @name = name

    ivar = "@#{name}"

    define_method(:initialize) do |*args, &block|
      instance_variable_set(ivar, args.first)
    end

    define_method(name) do
      instance_variable_get(ivar)
    end

    define_method(:method_missing) do |method_name, *args, &block|
      send(name).respond_to?(method_name) ? forward(method_name, *args, &block) : super(method_name, *args, &block)
    end

    define_method(:respond_to_missing?) do |method_name, include_all|
      send(name).respond_to?(method_name, include_all)
    end

    define_method(:forward) do |method_name, *args, &block|
      target = send(name)
      response = target.public_send(method_name, *args, &block)

      if response.equal?(target)
        self
      elsif response.kind_of?(target.class)
        self.class.new(response, *args)
      else
        response
      end
    end
  end
end
