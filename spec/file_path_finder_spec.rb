RSpec.describe EasyRspec::FilePathFinder do
  let(:directory){ 'app' }
  let(:klass){ 'Foo' }

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

        file_path_finder = EasyRspec::FilePathFinder.new(klass)
        expect(file_path_finder.file_path).to eq(matching_file_path)
      end
    end
  end

  context 'multiple matching paths' do
    let(:matching_file_path){ "app/foo.rb" }
    let(:second_matching_file_path){ "app/bar/foo.rb" }
    let(:decoy_file_path){ "app/random_file.rb" }
    it 'returns the user selected file' do
      FakeFS.with_fresh do
        FileUtils.mkdir_p "#{directory}/bar"
        File.write(matching_file_path, "")
        File.write(second_matching_file_path, "")
        File.write(decoy_file_path, "")

        file_path_finder = EasyRspec::FilePathFinder.new(klass)

        allow(file_path_finder)
          .to receive(:user_selected_file)
          .and_return(matching_file_path)
        expect(file_path_finder.file_path).to eq matching_file_path

        allow(file_path_finder)
          .to receive(:user_selected_file)
          .and_return(second_matching_file_path)
        expect(file_path_finder.file_path).to eq second_matching_file_path
      end
    end
  end

  context 'no matching file paths' do
    it 'raises an error' do
      FakeFS.with_fresh do
        FileUtils.mkdir_p directory

        file_path_finder = EasyRspec::FilePathFinder.new(klass)

        expect{ file_path_finder.file_path }.to raise_error
      end
    end
  end
end
