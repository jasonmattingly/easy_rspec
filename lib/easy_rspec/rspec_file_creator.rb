require 'fileutils'
module EasyRspec
  class RspecFileCreator
    def initialize(klass_name)
      @klass_name = klass_name
      @class_methods = []
      @instance_methods = []
    end

    def create
      puts file_path
      puts base_file_name
      puts rspec_file_name
      puts rspec_file_path
      #raise "File already exists" if File.file?(rspec_file_path)
      create_rspec_directory and create_rspec_file and rspec_file_contents
    end

    private

    def create_rspec_directory
      FileUtils.mkdir_p rspec_directory
    end

    def create_rspec_file
      File.new(rspec_file_path, 'w')
    end

    def rspec_file_contents
      File.open(rspec_file_path, "w+") do |f|
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

    def file_path
      @file_path ||= EasyRspec::FilePathFinder.new(@klass_name).file_path
    end

    def base_file_name
      EasyRspec::BaseFileNameFormatter.new(@klass_name).format.split('/').last
    end

    def rspec_directory
      directory.gsub('app/', 'spec/')
    end

    def directory
      file_path.split(base_file_name).first
    end

    def rspec_file_name
      base_file_name.gsub('.rb', '_spec.rb')
    end

    def rspec_file_path
      "#{rspec_directory}#{rspec_file_name}"
    end

    def file_contents
      @file_contents ||= FileContents.new(file_path)
    end

    def file_writer
      @file_writer ||= FileWriter.new(rspec_file_path)
    end

  end
end
