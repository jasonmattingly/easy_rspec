require 'fileutils'
module EasyRspec
  class RspecFileBuilder

    def initialize(klass_name)
      @klass_name = klass_name
    end

    def build
      return "RSpec file already exists at #{rspec_file.path}" if File.file?(rspec_file.path)

      FileUtils.mkdir_p rspec_file.directory
      File.new(rspec_file.path, 'w')

      File.open(rspec_file.path, "w+") do |f|
        f.write("describe #{original_file.klass_name}, type: :model do")

        file_contents.instance_methods.each do |instance_method|
          write_method_spec(f, "##{instance_method}")
        end

        file_contents.class_methods.each do |class_method|
          write_method_spec(f, ".#{class_method}")
        end

        f.write("\n\nend\n")
      end

      "RSpec file created successfully at #{rspec_file.path}"
    end

    private

    def original_file
      @original_file ||= OriginalFile.new(@klass_name)
    end

    def rspec_file
      @rspec_file ||= RspecFile.new(original_file)
    end

    def file_contents
      @file_contents ||= FileContents.new(original_file.path)
    end

    def write_method_spec(file, descriptor)
      file.write("\n")
      file.write("\n  describe '#{descriptor}' do")
      file.write("\n    context '' do")
      file.write("\n      it '' do")
      file.write("\n      end")
      file.write("\n    end")
      file.write("\n  end")
    end

  end
end
