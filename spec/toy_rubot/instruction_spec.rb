RSpec.describe ToyRubot::Instruction do
  subject { described_class.new(instruction, table) }

  describe '#process' do
    let(:table) do
      table = ToyRubot::Table.new
      table.robots = { 'ALICE' => ToyRubot::RobotPosition.new([0, 1], 'EAST') }
      table
    end

    context 'with a PLACE command' do
      let(:instruction) { 'ALICE: PLACE 0,2,EAST' }

      it 'returns the table with the placed robot' do
        expect(subject.process.robots).to eql({ 'ALICE' => ToyRubot::RobotPosition.new([0, 2], 'EAST') })
      end
    end

    context 'with a TURN command' do
      let(:instruction) { 'ALICE: RIGHT' }

      it 'returns the table with the rotated robot' do
        expect(subject.process.robots).to eql({ 'ALICE' => ToyRubot::RobotPosition.new([0, 1], 'SOUTH') })
      end
    end

    context 'with a REPORT command' do
      let(:instruction) { 'ALICE: REPORT' }

      it 'returns the table with the robot in the same place' do
        expect(subject.process.robots).to eql(table.robots)
      end
    end
  end
end
