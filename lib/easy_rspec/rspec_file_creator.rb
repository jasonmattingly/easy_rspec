require 'fileutils'
module EasyRspec
  class RspecFileCreator
    def initialize(klass_name)
      @klass_name = klass_name
    end

    def create
      #create_directory and
      create_rspec_file
    end

    private

    def create_directory
      FileUtils.mkdir_p target_directory
    end

    def create_rspec_file
      FileUtils.mkdir_p 'spec/blah'
      File.new("spec/#{formatted_file_path}", 'w')
      File.open("spec/#{formatted_file_path}", "w+") do |f|
        f.write("class Rspec::Testing\nAnotherTest" + "\n  AndAnother")
      end
    end

    def testable_file_path
      @testable_file_path ||= EasyRspec::FilePathFinder.new(@klass_name).file_path
    end

    def target_directory
      "spec/#{formatted_directory_path}"
    end

    def base_file_name
      EasyRspec::BaseFileNameFormatter.new(@klass_name).format
    end

    def formatted_file_path
      testable_file_path.split('app/').last
    end

    def formatted_directory_path
      formatted_file_path.split(base_file_name).first
    end

  end
end
