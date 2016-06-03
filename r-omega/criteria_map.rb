require 'matrix'

class CriteriaMap
  attr_accessor :map, :classes, :type,

  ACCEPTABLE_TYPES = %i(equivalence strict_order quasy_order)

  def initialize(options)
    if options[:file_path]
      @map, @classes, @type = load_from_file(file_path)
    else
      @map = options[:map].is_a? Array ? Matrix.rows(options[:map]) : options[:map]
      @classes = options[:classes] || 1
      @type = options[:type]
    end

    raise Exception if !ACCEPTABLE_TYPES.include?(@type) || @map.empty?
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
end
