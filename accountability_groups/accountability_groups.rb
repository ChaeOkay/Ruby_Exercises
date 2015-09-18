require 'byebug'

class Cohort
  attr_reader :roster
  attr_accessor :groups

  def initialize(roster)
    @roster = roster
    @groups = []
  end

  def randomize_roster
    roster.shuffle
  end

  def divide
    divy(randomize_roster, 5).each { |subgroup| groups << subgroup }
    return groups if valid_group_sizes?
    subgroup = combine_remainder
    divy(subgroup, 4).each { |subgroup| groups << subgroup }
    return groups if valid_group_sizes?
    subgroup = combine_remainder
    divy(subgroup, 3).each { |subgroup| groups << subgroup }
    return groups if valid_group_sizes?
  end

  def valid_group_sizes?
    groups.all? { |group| 3 <= group.size && group.size <= 5  }
  end

  private

  def combine_remainder
    subgroup = groups.pop
    subgroup << groups.pop
    subgroup.flatten
  end

  def divy(group, persons_per_group)
    group.enum_for(:each_slice, persons_per_group).to_a
  end
end
