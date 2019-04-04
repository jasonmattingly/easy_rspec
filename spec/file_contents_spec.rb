RSpec.describe EasyRspec::FileContents do
  let(:directory){ 'app/' }
  let(:file_path){ "app/foo.rb" }
  let(:expected_instance_methods){ ['instance_method_1', 'instance_method_2'] }
  let(:expected_class_methods){ ['class_method_1', 'class_method_2'] }
  it 'correctly parses the file for all needed contents' do
    FakeFS do
      FileUtils.mkdir_p directory
      File.write(file_path, content)
      file_contents = EasyRspec::FileContents.new(file_path)

      expect(file_contents.instance_methods).to match_array(expected_instance_methods)
      expect(file_contents.class_methods).to match_array(expected_class_methods)
    end
  end

  def content
    <<-RUBY
    class TestClass
      def instance_method_1
      end

      def self.class_method_1
      end

      def instance_method_2
      end

      def self.class_method_2
      end
    end
    RUBY
  end
end
