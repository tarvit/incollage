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

      def load_modules_in(dir)
        valid_entries(dir).each do |m|
          load_core_dependency m, dir
        end
      end

      def load_modules(core_path)
        valid_entries(core_path).each do |dir|
          load_modules_in core_path.join(dir)
        end
      end

      private

      def valid_entries(dir)
        Dir.open(dir).entries.select do |entry|
          !%w{ . .. }.include?(entry) && File.directory?(dir.join(entry))
        end
      end

    end

  end
end


