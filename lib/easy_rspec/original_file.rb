module EasyRspec
  class OriginalFile

    attr_reader :klass_name

    def initialize(klass_name)
      @klass_name = constantized_klass_name(klass_name)
    end

    def path
      @path ||= FilePathFinder.new(@klass_name).file_path
    end

    def directory
      @directory ||= path.split(name).first
    end

    def name
      @name ||= path.split('/').last
    end

    private

    def constantized_klass_name(klass_name)
      Object.const_get(klass_name == Class ? klass_name.name : klass_name.to_s)
    end

  end
end
