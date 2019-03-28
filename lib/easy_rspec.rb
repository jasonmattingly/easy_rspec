require "easy_rspec/version"
require 'pry'
module EasyRspec
  class Error < StandardError; end
  require 'easy_rspec/file_path_finder.rb'
  require 'easy_rspec/base_file_name_formatter.rb'
end
