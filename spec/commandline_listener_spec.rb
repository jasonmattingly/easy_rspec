RSpec.describe Kernel do
  describe '#easy_rspec' do
    let(:mock_constant_param){ Class }
    let(:mock_returned_instance){ 'instance' }
    let(:mock_returned_value){ 'value' }
    let(:perform){ Kernel.easy_rspec(mock_constant_param) }
    it 'creates an instance of EasyRspec::RspecFileBuilder and calls build method on that instance' do
      expect(EasyRspec::RspecFileBuilder)
        .to receive(:new)
        .with(mock_constant_param)
        .and_return(mock_returned_instance)
      expect(mock_returned_instance)
        .to receive(:build)
        .and_return(mock_returned_value)
      perform
    end
  end
end
