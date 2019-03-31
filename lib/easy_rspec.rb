require "easy_rspec/version"
require 'pry'
module EasyRspec
  class Error < StandardError; end
  require 'easy_rspec/file_path_finder.rb'
<<<<<<< Updated upstream
  require 'easy_rspec/base_file_name_formatter.rb'
  require 'easy_rspec/rspec_file_creator.rb'
  require 'easy_rspec/base_file_directory.rb'
=======
  require 'easy_rspec/file_contents.rb'
  require 'easy_rspec/commandline_listener.rb'
>>>>>>> Stashed changes
end
