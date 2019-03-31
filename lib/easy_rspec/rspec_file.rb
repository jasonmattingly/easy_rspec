module EasyRspec
  class RspecFile

    def initialize(original_file)
      @original_file = original_file
    end

    def path
      "#{directory}#{name}"
    end

    def directory
      @original_file.directory.sub('app/', 'spec/')
    end

    def name
      @original_file.name.sub('.rb', '_spec.rb')
    end

  end
end
