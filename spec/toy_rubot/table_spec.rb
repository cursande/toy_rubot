RSpec.describe ToyRubot::Table do
  subject { described_class.new }

  describe '#valid?' do
    context 'with a table in a valid state' do
      before do
        subject.robots = {
          'ALICE' => ToyRubot::RobotPosition.new([2, 2], 'EAST'),
          'BOB' => ToyRubot::RobotPosition.new([1, 2], 'SOUTH'),
        }
      end

      it 'returns as valid' do
        expect(subject.valid?).to eql true
      end
    end

    context 'with a table in an invalid state' do
      before do
        subject.robots = {
          'ALICE' => ToyRubot::RobotPosition.new([2, 2], 'EAST'),
          'BOB' => ToyRubot::RobotPosition.new([2, 2], 'SOUTH'),
        }
      end

      it 'returns as invalid' do
        expect(subject.valid?).to eql false
      end
    end
  end
end
