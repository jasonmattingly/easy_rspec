require 'fileutils'
module EasyRspec
  class RspecFileCreator
    def initialize(klass_name)
      @klass_name = klass_name
      @class_methods = []
      @instance_methods = []
    end

    def create
      #raise "File already exists" if File.file?(rspec_file_path)
      methods
      create_directory and create_rspec_file and rspec_file_contents
    end

    def methods
      File.foreach(file_path) do |line|
        if line.include? 'def'
          if line.include? 'def self.'
            @class_methods << line.gsub('def self.','').gsub('\n', '').strip
          else
            @instance_methods << line.gsub('def','').gsub('\n', '').strip
          end
        end
      end
    end

    private

    def create_directory
      FileUtils.mkdir_p rspec_directory
    end

    def create_rspec_file
      File.new(rspec_file_path, 'w')
    end

    def rspec_file_contents
      File.open(rspec_file_path, "w+") do |f|
        f.write("describe #{@klass_name}, type: :model do")
        if @instance_methods.any?
          f.write("\n")
          @instance_methods.each do |instance_method|
            f.write("\n  describe '##{instance_method}' do")
            f.write("\n    context '' do")
            f.write("\n      it '' do")
            f.write("\n      end")
            f.write("\n    end")
            f.write("\n  end")
            f.write("\n")
          end
        end
        if @class_methods.any?
          f.write("\n")
          @class_methods.each do |class_method|
            f.write("\n  describe '.#{class_method}' do")
            f.write("\n    context '' do")
            f.write("\n      it '' do")
            f.write("\n      end")
            f.write("\n    end")
            f.write("\n  end")
            f.write("\n")
          end
        end
        f.write("\nend")
      end
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

  end
end
