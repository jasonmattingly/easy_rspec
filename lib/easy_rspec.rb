require "easy_rspec/version"
require 'pry'
module EasyRspec
  class Error < StandardError; end
  require 'easy_rspec/original_file.rb'
  require 'easy_rspec/rspec_file.rb'
  require 'easy_rspec/rspec_file_builder.rb'
  require 'easy_rspec/file_path_finder.rb'
  require 'easy_rspec/file_contents.rb'
  require 'easy_rspec/commandline_listener.rb'
end
