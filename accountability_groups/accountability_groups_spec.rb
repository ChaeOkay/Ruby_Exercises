require 'rspec'
require 'byebug'
require_relative 'accountability_groups'

describe Cohort do
  let(:cohort) { described_class.new(roster) }

  describe '#divide' do
    context 'with 11 students' do
      let(:roster) { %W(1 2 3 4 5 6 7 8 9 10 11) }
      let(:groups) { cohort.divide }

      it 'has valid group sizes' do
        expect(cohort.valid_group_sizes?).to eq true
      end

      it 'has shuffled students' do
        expect(groups[0][1..3]).to_not eq [1, 2, 3]
      end
    end

    context 'with 17 students' do
      let(:roster) { %W(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) }
      let(:groups) { cohort.divide }

      it 'has valid group sizes' do
        expect(cohort.valid_group_sizes?).to eq true
      end

      it 'has shuffled students' do
        expect(groups[0][1..3]).to_not eq [1, 2, 3]
      end
    end
  end
end
