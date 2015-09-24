module Incollage

  module Core
    MODULES = %w{
      instagram
    }

    class << self
      def load_core_dependency root, module_name
        dependency_path = root.join(['app', 'core', module_name, module_name+'.rb' ]*?/)
        load dependency_path

        submodules_path = root.join(['app', 'core', module_name, 'modules']*?/)

        if Dir.exist?(submodules_path)
          (Dir.foreach(submodules_path)).each do |submodule_path|
            next unless submodule_path.ends_with? '.rb'
            load [submodules_path, submodule_path]*?/
          end
        end
      end

      def load_modules(root)
        MODULES.each do |m|
          load_core_dependency root, m
        end
      end
    end

  end
end


