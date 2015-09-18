class Cohort
  attr_reader :roster, :max, :min
  attr_accessor :groups

  def initialize(roster, max: 5, min: 3)
    @roster = roster
    @groups = []
    @max = max
    @min = min
  end

  def divide
    (min..max).reverse_each do |group_size|
      invalid_group = groups.empty? ? roster : combine_invalid_group
      divy(invalid_group, group_size).each { |subgroup| groups << subgroup }
      return groups if valid_group_sizes?
    end
  end

  def valid_group_sizes?
    groups.all? { |group| min <= group.size && group.size <= max  }
  end

  private

  def randomize_roster
    roster.shuffle
  end

  def combine_invalid_group
    invalid_group = groups.pop
    invalid_group << groups.pop
    invalid_group.flatten
  end

  def divy(invalid_group, persons_per_group)
    invalid_group.enum_for(:each_slice, persons_per_group).to_a
  end
end
