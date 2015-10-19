module TestSupport
  class FakeAbstractService

    def initialize(methods=nil)
      @methods = [ methods ].flatten.compact
    end

    def method_missing(name, *args)
      if @methods.empty?
        any_method_missing(name, *args)
      else
        direct_method_missing(name, *args)
      end
    end

    protected

    def direct_method_missing(name, *args)
      raise NoMethodError unless @methods.include?(name)
    end

    def any_method_missing(name, *args); end

  end
end
