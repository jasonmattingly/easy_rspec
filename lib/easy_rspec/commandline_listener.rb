module Kernel
  def easy_rspec(klass_name)
    EasyRspec::RspecFileBuilder.new(klass_name).build
  end
end
#