class Relation
  attr_accessor :graph

  def initialize(map)
    @graph = map
  end

  def size
    @size ||= @graph.size
  end

  def connect_P(i, j)
    set_P(i, j, 1)
  end

  def connect_I(i, j)
    set_I(i, j, 1)
  end

  def set_I(i, j, value)
    graph[i][j] = value
    graph[j][i] = value
  end

  def connection_init?(i, j)
    graph[i][j] != -1
  end

  def set_P(i, j, value)
    if value == 0
      graph[i][j] = value
    else
      graph[i][j] = value
      graph[j][i] = 0
    end
  end

  class << self
    def empty(size)
      Relation.new(Array.new(size, Array.new(size, -1)))
    end

    def zeros(size)
      Relation.new(Array.new(size, Array.new(size, 0)))
    end
  end
end
