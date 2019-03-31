module EasyRspec
  class FileContents
    attr_accessor :instance_methods, :class_methods

    def initialize(file_path)
      self.instance_methods = []
      self.class_methods = []
      find_contents(file_path)
    end

    private

    def find_contents(file_path)
      File.foreach(file_path) do |line|
        if line_contains_instance_method?(line)
          class_methods << extracted_class_method_name(line)
        elsif line_contains_class_method?(line)
          instance_methods << extracted_instance_method(line)
        end
      end
    end

    def line_contains_instance_method?(line)
      line.include? 'def self.'
    end

    def extracted_instance_method(line)
      line.gsub('def ','').gsub('\n', '').strip
    end

    def line_contains_class_method?(line)
      line.include? 'def '
    end

    def extracted_class_method_name(line)
      line.gsub('def self.','').gsub('\n', '').strip
    end

  end
end
