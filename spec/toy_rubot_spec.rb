RSpec.describe ToyRubot do
  describe '.run' do
    let(:path)  { File.join(__dir__, 'fixtures', 'test_instructions.txt') }

    it 'outputs the correct positions of the robots when reporting' do
      expect { ToyRubot.run(path) }.to output(<<~OUT).to_stdout
          ALICE: 3,3,NORTH
          BOB: 4,2,SOUTH
      OUT
    end
  end
end
