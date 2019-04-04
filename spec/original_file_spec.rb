RSpec.describe EasyRspec::OriginalFile do
  let(:subject){ EasyRspec::OriginalFile.new(klass) }
  context 'parameter klass name can be string or constant' do
    let(:string_klass){ 'Class' }
    let(:constant_klass){ Class }
    context 'subject initialized with klass string' do
      let(:klass){ string_klass }
      it 'converts a string klass_name to a constant' do
        expect(subject.klass_name).to eq(constant_klass)
      end
    end
    context 'subject initialized with constant_klass' do
      let(:klass){ constant_klass }
      it 'maintains the constant klass_name' do
        expect(subject.klass_name).to eq(constant_klass)
      end
    end
  end
  context 'file path is found and formattable' do
    let(:klass){ Class }
    let(:expected_path){ "app/class.rb" }
    let(:expected_directory){ 'app/' }
    let(:expected_name){ 'class.rb' }
    it 'correctly formats all instance method return values' do
      FakeFS.with_fresh do
        FileUtils.mkdir_p expected_directory
        File.write(expected_path, '')
        expect(subject.path).to eq(expected_path)
        expect(subject.directory).to eq(expected_directory)
        expect(subject.name).to eq(expected_name)
      end
    end
  end
end
