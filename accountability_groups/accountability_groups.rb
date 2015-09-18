class Cohort
  attr_reader :roster, :max, :min
  attr_accessor :groups

  def initialize(roster, max: 5, min: 3)
    @roster = roster #[1,2,3,4,5,6,7,8,9,10,11]
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
    invalid_group = groups.pop #[11]
    invalid_group << groups.pop #[6,7,8,9,10]
    invalid_group.flatten #[11,6,7,8,9,10]
  end

  def divy(invalid_group, persons_per_group)
    invalid_group.enum_for(:each_slice, persons_per_group).to_a #[[1,2,3,4,5],[6,7,8,9,10],[11]]
  end
end


# Not the best OOD, but gets the job done :)
# If this code were to be used in a code base that would be around for awhile
# and extensible, I would probably create:
#   Cohort as collection of students
#   Student as a Struct
#   Group as a Class with a min and max size, holds a collection of student objects
#   GroupGenerator that does the work
