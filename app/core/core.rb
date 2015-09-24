module Incollage

  module Core

    class << self
      def load_core_dependency module_name, core_path
        dependency_path = core_path.join([module_name, module_name+'.rb' ]*?/)
        load dependency_path

        submodules_path = core_path.join([module_name, 'modules']*?/)

        if Dir.exist?(submodules_path)
          (Dir.foreach(submodules_path)).each do |submodule_path|
            next unless submodule_path.ends_with? '.rb'
            load [submodules_path, submodule_path]*?/
          end
        end
      end

      def load_modules(core_path)
        Dir.foreach(core_path) do |m|
          next if %w{ . .. }.include?(m) || !File.directory?(core_path.join(m))
          load_core_dependency m, core_path
        end
      end
    end

  end
end


