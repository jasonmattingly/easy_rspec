RSpec.describe EasyRspec::OriginalFile do
  let(:klass){ Class }
  let(:original_file){ EasyRspec::OriginalFile.new(klass) }
  let(:subject){ EasyRspec::RspecFile.new(original_file) }
  context 'original file is immediately inside the app directory' do
    let(:original_file_path){ "app/class.rb" }
    let(:original_file_directory){ 'app/' }

    let(:expected_path){ 'spec/class_spec.rb' }
    let(:expected_directory){ 'spec/' }
    let(:expected_name){ 'class_spec.rb' }
    it 'correctly determines the attributes based on the original file details' do
      FakeFS.with_fresh do
        FileUtils.mkdir_p original_file_directory
        File.write(original_file_path, '')

        expect(subject.path).to eq(expected_path)
        expect(subject.directory).to eq(expected_directory)
        expect(subject.name).to eq(expected_name)
      end
    end
  end
  context 'original file is nested within multiple folders' do
    let(:original_file_path){ "app/foo/bar/class.rb" }
    let(:original_file_directory){ 'app/foo/bar/' }

    let(:expected_path){ 'spec/foo/bar/class_spec.rb' }
    let(:expected_directory){ 'spec/foo/bar/' }
    let(:expected_name){ 'class_spec.rb' }
    it 'correctly determines the attributes based on the original file details' do
      FakeFS.with_fresh do
        FileUtils.mkdir_p original_file_directory
        File.write(original_file_path, '')

        expect(subject.path).to eq(expected_path)
        expect(subject.directory).to eq(expected_directory)
        expect(subject.name).to eq(expected_name)
      end
    end
  end
end
