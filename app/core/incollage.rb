module Incollage

  extend TarvitHelpers::RecursiveLoader::Context

  class << self

    def load
      load_modules(root, load_priorities)
    end

    def root
      Pathname.new(File.expand_path(__FILE__)).parent
    end

    private

    def load_priorities
      %w{
        abstract base
        entities interactors adapters components holders
        histogram picture clipping
      }
    end
  end
end
