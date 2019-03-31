require 'find'
module EasyRspec
  class FilePathFinder

    def initialize(klass_name)
      @klass_name = klass_name
    end

    def file_path
     matching_file_paths.last
     # matching_file_paths.one? ? matching_file_paths.first : nil
    end

    private

    def file_name
      "#{file_name_components.join('/')}.rb"
    end

    def file_name_components
      klass_name_components.map{ |component| component.gsub(/(.)([A-Z])/,'\1_\2').downcase }
    end

    def klass_name_components
      @klass_name.to_s.split('::')
    end

    def matching_file_paths
      app_file_paths.select{ |file_path| file_path.include? "/#{file_name}" }
    end

    def app_file_paths
      Find.find('app/').select { |file| File.extname(file) == '.rb' }
    end

  end
end
