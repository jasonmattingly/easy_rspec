require 'fileutils'
module EasyRspec
  class RspecFileCreator
    def initialize(klass_name)
      @klass_name = klass_name
    end

    def create
      #raise "File already exists" if File.file?(rspec_file_path)
      create_directory and create_rspec_file and rspec_file_contents
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
        f.write("\nend")
      end
    end

    def methods
      @klass.try(:classify).instance_methods - Object.instance_methods
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
