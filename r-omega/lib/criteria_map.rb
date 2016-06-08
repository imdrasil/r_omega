class CriteriaMap
  attr_accessor :map, :classes, :type

  ACCEPTABLE_TYPES = %i(equivalence strict_order quasy_order).freeze

  ACCEPTABLE_TYPES.each do |t|
    define_method("#{t}?") do
      @type == t
    end
  end

  def initialize(options)
    @classes = options[:classes] || [0...options[:map].first.size]
    @type = options[:type]
    @map = convert_map(options[:map])

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
    def build_series(options)
      if options[:directory]
        Dir[File.join(options[:file_name], '*.txt')].map do |path|
          parse_file(path)
        end.flatten
      else
        parse_file(options[:file_name])
      end
    end

    def parse_file(path) # TODO: need checking
      arr = []
      File.open(path, 'r') do |f|
        count = f.gets.to_i
        arr = count.times.map do
                alt = f.gets.to_i
                crit = f.gets.to_i
                type = f.gets.strip.to_sym
                matrix = crit.times.map { f.gets.split(' ').map(&:to_i) }
                classes = parse_classes_from_file(f, type)
                CriteriaMap.new(classes: classes, map: matrix, type: type)
              end
      end
      arr
    end

    private

    def parse_classes_from_file(file, type)
      if type == :quasy_order
        temp = file.gets.split(' ').map(&:to_i)
        sum = 0
        temp.map do |i|
          range = sum...(sum + i)
          sum += i
          range
        end
      end
    end
  end

  private

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
