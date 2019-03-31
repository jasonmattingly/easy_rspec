require 'find'
module EasyRspec
  class FilePathFinder

    def initialize(klass_name)
      @klass_name = klass_name
    end

    def file_path
      file = if matching_file_paths.one?
        matching_file_paths.first
      elsif matching_file_paths.size > 1
        user_selected_file
      else
        nil
      end
      raise "File not found" unless file.present?
      file
    end

    private

    def user_selected_file
      max_index = matching_file_paths.size - 1
      index = user_selected_index
      if index.present? && index <= max_index
        matching_file_paths[index]
      else
        nil
      end
    end

    def user_selected_index
      puts "\nWhich number represents your file path?\n\n"
      matching_file_paths.each_with_index do |file_path, index|
        puts "#{index}. #{file_path}"
      end
      puts "\n"
      user_provided_index = gets.gsub(/[^\d]/, '')
      user_provided_index.present? ? user_provided_index.to_i : nil
    end

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
      @matching_file_paths ||= app_file_paths.select{ |file_path| file_path.include? "/#{file_name}" }
    end

    def app_file_paths
      Find.find('app/').select { |file| File.extname(file) == '.rb' }
    end

  end
end
