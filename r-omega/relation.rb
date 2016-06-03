class Relation
  attr_accessor :graph

  def initialize(map)
    @graph = map
  end

  def symmetric_part # TODO: finish
    graph.each_with_index.map { |i, row| row.each_with_index.map { |j, e| 0 } }
  end

  def asymmetric_part # TODO: finish
    graph.each_with_index.map { |i, row| row.each_with_index.map { |j, e| 0 } }
  end

  class << self
    def empty(size)
      Array.new(size) { [-1] * size }
    end

    def zeros(size)
      Array.rows(size) { [0] * size }
    end
  end
end
