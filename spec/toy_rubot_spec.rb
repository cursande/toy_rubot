RSpec.describe ToyRubot do
  let(:path)  { 'test_instructions.txt' }

  let(:test_file) do
    Tempfile.open(path) do |f|
      instructions.each { |instruction| f.write(instruction) }
    end
  end

  let(:instructions) do
    [
      "ALICE: PLACE 1,2,EAST",
      "ALICE: MOVE",
      "ALICE: MOVE",
      "ALICE: LEFT",
      "BOB: PLACE 3,3,EAST",
      "BOB: MOVE",
      "ALICE: MOVE",
      "ALICE: REPORT",
      "BOB: RIGHT",
      "BOB: MOVE",
      "BOB: REPORT"
    ]
  end

  it 'outputs the correct positions of the robots when reporting' do
    expect { ToyRobot::Runner.new(path).run }.to output(<<~OUT).to_stdout
          ALICE: 3,3,NORTH
          BOB: 4,2,SOUTH
      OUT
  end
end
