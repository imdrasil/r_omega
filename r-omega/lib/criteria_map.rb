class CriteriaMap
  attr_accessor :map,
                :classes, # [Range]
                :type

  ACCEPTABLE_TYPES = %i(equivalence strict_order quasy_order).freeze

  def initialize(options)
    if options[:file_path]
      @map, @classes, @type = load_from_file(file_path)
      @map = convert_map(@map)
    else
      @classes = options[:classes] || [0...options[:map].first.size]
      @type = options[:type]
      @map = convert_map(options[:map])
    end

    raise Exception if !ACCEPTABLE_TYPES.include?(@type) || @map.nil? || @map.empty?
  end

  def alternative_count
    @map.size
  end

  def better_than?(i, j)
    any_better = false
    sum_i = 0
    sum_j = 0
    criteria_count.times do |c|
      sum_i += map[i][c]
      sum_j += map[j][c]
      dif = sum_i <=> sum_j
      return false if dif == -1
      any_better = true if dif == 1
    end
    any_better
  end

  def same_as?(i, j)
    sum_i = 0
    sum_j = 0
    criteria_count.times do |c|
      sum_i += map[i][c]
      sum_j += map[j][c]
      dif = sum_i <=> sum_j
      return false if dif != 0
    end
    true
  end

  def criteria_count
    @map.first.count
  end

  def print
    @map.map { |row| row.join(' ') }.join("\n")
  end

  class << self
    def build_series(file_path)
      lines = File.readlines(file_path)
      # TODO: finish
    end
  end

  private

  def load_from_file(file_path)
    File.readlines(file_path)
    # TODO: finish
  end

  def convert_map(arr)
    case type
      when :equivalence
        arr.map { |row| [row.inject(&:+)] }
      when :strict_order
        arr
      when :quasy_order
        arr.map { |row| classes.map { |klass| row[klass].inject(&:+) } }
    end
  end
end
