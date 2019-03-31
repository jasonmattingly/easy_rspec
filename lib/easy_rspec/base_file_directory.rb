module EasyRspec
  class BaseFileDirectory
    def initialize(klass_name)
      @klass_name = klass_name
    end

    def directory
      directory_components.join('/')
    end

    private

    # Removes filename from directory components
    def directory_components
      directory_components = file_path_components
      directory_components.pop
      directory_components
    end

    def file_path_components
      file_path.split('/')
    end

    def file_path
      FilePathFinder.new(@klass_name).file_path
    end

  end
end
