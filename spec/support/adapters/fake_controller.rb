module TestSupport
  class FakeController
    attr_reader :params, :redirects, :renders

    def initialize(params={})
      @redirects, @renders = [], []
      @params = params
    end

    def redirect_to(url)
      @redirects << url
    end

    def render(*args)
      @renders << args
    end

    def success(*args)
      render(*args)
    end

    protected

    def routes
      Rails.application.routes.url_helpers
    end

    def method_missing(m, *args)
      if m.to_s.ends_with?('_path') || m.to_s.ends_with?('_url')
        routes.send(m, *args)
      else
        super
      end
    end
  end
end
