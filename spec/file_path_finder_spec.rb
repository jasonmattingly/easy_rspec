RSpec.describe EasyRspec::FilePathFinder do
  let(:directory){ 'app/' }
  let(:klass){ 'Foo' }
  let(:subject){ EasyRspec::FilePathFinder.new(klass) }

  describe '#file_path' do
    context 'one matching path' do
      let(:matching_file_path){ "app/foo.rb" }
      let(:decoy_file_path_1){ "app/foo_bar.rb" }
      let(:decoy_file_path_2){ "app/random_file.rb" }
      it 'finds and returns the matching path' do
        FakeFS.with_fresh do
          FileUtils.mkdir_p directory
          File.write(matching_file_path, "")
          File.write(decoy_file_path_1, "")
          File.write(decoy_file_path_2, "")
          expect(subject.file_path).to eq(matching_file_path)
        end
      end
    end
    context 'multiple matching paths' do
      let(:matching_file_path){ "app/foo.rb" }
      let(:second_matching_file_path){ "app/bar/foo.rb" }
      let(:matching_file_paths_stub){ [matching_file_path, second_matching_file_path] }
      let(:decoy_file_path){ "app/random_file.rb" }
      let(:random_selection){ [ ['0', matching_file_paths_stub[0]], ['1', matching_file_paths_stub[1]] ].sample }

      before(:each) do
        allow(subject).to receive(:matching_file_paths).and_return(matching_file_paths_stub)
      end
      context 'user provides a valid file index' do
        it 'returns the file indicated by the user' do
          allow(STDIN).to receive(:gets).and_return(random_selection[0])
          expect(subject.file_path).to eq(random_selection[1])
        end
      end
      context 'user provides an invalid file index' do
        let(:invalid_user_provided_index){ '9' }
        it 'raises a runtime error' do
          allow(STDIN).to receive(:gets).and_return(invalid_user_provided_index)
          expect{ subject.file_path }.to raise_error(RuntimeError, 'File path not found')
        end
      end
      context 'user provides index along with random characters' do
        let(:index_with_random_chars){ 'j&sd1sPd' }
        let(:user_selected_file){ matching_file_paths_stub[1] }
        it 'parses the string to use the index successfully' do
          allow(STDIN).to receive(:gets).and_return(index_with_random_chars)
          expect(subject.file_path).to eq(user_selected_file)
        end
      end
    end
    context 'no matching file paths' do
      it 'raises a runtime error' do
        FakeFS.with_fresh do
          FileUtils.mkdir_p directory
          expect{ subject.file_path }.to raise_error(RuntimeError, 'File path not found')
        end
      end
    end
  end
end
