module EasyRspec
  class FileWriter
    def initializer(file_path)
      @file_path = file_path
    end

    def rspec_file_contents
      File.open(@file_path, "w+") do |f|
        f.write("describe #{@klass_name}, type: :model do")

        file_contents.instance_methods.each do |instance_method|
          write_method(f, "##{instance_method}")
        end
        file_contents.class_methods.each do |class_method|
          write_method(f, ".#{class_method}")
        end

        f.write("\n\nend\n")
      end
    end

    def write_method(file, descriptor)
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
