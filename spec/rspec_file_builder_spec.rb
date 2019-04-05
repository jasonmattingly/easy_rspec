RSpec.describe EasyRspec::RspecFileBuilder do
  let(:klass){ Class }
  let(:subject){ EasyRspec::RspecFileBuilder.new(klass) }

  describe '#build' do
    let(:perform){ subject.build }

    let(:original_file_path){ 'app/class.rb' }
    let(:original_file_directory){ 'app/' }
    let(:rspec_file_creation_directory){ 'spec/' }
    let(:rspec_file_creation_path){ 'spec/class_spec.rb' }
    context 'when file already exists at the determined file creation path' do
      let(:expected_error_message){ "RSpec file already exists at #{rspec_file_creation_path}" }
      it 'raises an error that the file already exists' do
        FakeFS.with_fresh do
          FileUtils.mkdir_p original_file_directory
          File.write(original_file_path, '')
          FileUtils.mkdir_p rspec_file_creation_directory
          File.write(rspec_file_creation_path, '')
          expect{ perform }.to raise_error(RuntimeError, expected_error_message)
        end
      end
    end
    context 'when file does not already exists at the determined file creation path' do
      it 'creates an rspec file at the correct location with the correct content' do
        FakeFS.with_fresh do
          FileUtils.mkdir_p original_file_directory
          File.write(original_file_path, content)

          expect(perform).to eq("RSpec file created successfully at #{rspec_file_creation_path}")
          expect(File.file?(rspec_file_creation_path)).to be true

          # Copy file content w/o whitespace for string comparison
          file_content = File.open(rspec_file_creation_path) {|f| f.read }.gsub!(/\s+/, "")

          expect(file_content).to eq(expected_rspec_file_contents)
        end
      end
      def content
        <<-RUBY
        class Class
          def instance_method_1
            puts "hello"
          end

          def self.class_method_1
            1 + 1
          end

          def instance_method_2
            if true
              "base"
            else
              "ball"
            end
          end

          def self.class_method_2
            word_contains_def_and_self = true
            if word_contains_def_and_self
              "hopefully parser is smart enough to ignore it"
            end
          end
        end
        RUBY
      end

      def expected_rspec_file_contents
        """
        describe Class, type: :model do

          describe '#instance_method_1' do
            context '' do
              it '' do
              end
            end
          end

          describe '#instance_method_2' do
            context '' do
              it '' do
              end
            end
          end

          describe '.class_method_1' do
            context '' do
              it '' do
              end
            end
          end

          describe '.class_method_2' do
            context '' do
              it '' do
              end
            end
          end

        end
        """.gsub(/\s+/, "")
      end
    end
  end

end

