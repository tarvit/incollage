module Incollage

  module Core
    MODULES = %w{
      instagram
    }

    class << self
      def load_core_dependency module_name
        #module_path = Rails.root.join(['app', 'core', module_name, module_name ]*?/)
        #require module_path
        require_relative [module_name, module_name ]*?/
      end

      def load_modules
        MODULES.each do |m|
          load_core_dependency m
        end
      end
    end
  end
end

Incollage::Core.load_modules

