module Incollage

  class << self

    def load_modules(core_path, priorities=%w{ base entities interactors adapters })
      load_ruby_files(core_path)
      (priorities + global_dirs(core_path)).each do |dir|
        load_modules_in core_path.join(dir)
      end
    end

    private

    def global_dirs(dir)
      (valid_directories(dir)).uniq
    end

    def load_modules_in(dir)
      load_ruby_files(dir)
      valid_directories(dir).each do |subdir|
        load_modules_in dir.join(subdir)
      end
    end

    def valid_directories(dir)
      Dir.open(dir).entries.select do |entry|
        !%w{ . .. }.include?(entry) && File.directory?(dir.join(entry))
      end
    end

    def load_ruby_files(dir)
      ruby_files(dir).each do |rb|
        load dir.join(rb)
      end
    end

    def ruby_files(dir)
      Dir.open(dir).entries.select do |entry|
        entry.ends_with? '.rb'
      end
    end

  end
end


