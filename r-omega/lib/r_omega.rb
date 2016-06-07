require 'relation'

class ROmega < Relation
  attr_accessor :map

  def initialize(criteria_map)
    @map = criteria_map
    @graph = Array.new(@map.alternative_count) { Array.new(@map.alternative_count, -1) }
    fill_I
    fill_P
    fill_N
  end

  def fill_P
    @map.alternative_count.times do |row|
      @map.alternative_count.times do |col|
        next if connection_init?(row, col)
        connect_P(row, col) if @map.better_than?(row, col)
      end
    end
  end

  def fill_I
    (0...@map.alternative_count).each do |row|
      (row...@map.alternative_count).each do |col|
        next if connection_init?(row, col)
        connect_I(row, col) if @map.same_as?(row, col)
      end
    end
  end

  def fill_N
    @map.alternative_count.times do |row|
      @map.alternative_count.times do |col|
        @graph[row][col] = 0 if @graph[row][col] == -1
      end
    end
  end

  def print
    @graph.map { |r| r.join(' ') }.join("\n")
  end
end
