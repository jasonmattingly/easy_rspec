require 'find'
module EasyRspec
  class FilePathFinder

    def initialize(klass_name)
      @base_file_name = base_file_name(klass_name)
    end

    def file_path
      binding.pry
      matching_file_paths.one? ? matching_file_paths.first : nil
    end

    private

    def base_file_name(klass_name)
      EasyRspec::BaseFileNameFormatter.new(klass_name).format
    end

    def matching_file_paths
      app_file_paths.select{ |file_path| file_path.include? @base_file_name }
    end

    def app_file_paths
      Find.find('app/').select { |file| File.extname(file) == FileExtensions::RUBY }
    end

  end
end
