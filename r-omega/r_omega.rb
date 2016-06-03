class ROmega
  def initialize(criteria_map)
    @criterias = criteria_map

  end

  def build_relation
    fill_P
    fill_I
  end

  def fill_P
    case @criterias.type
      when :equivalence

      when :strict_order

      when :quasy_order

    end
  end

  def fill_I
    case @criterias.type
      when :equivalence

      when :strict_order

      when :quasy_order

    end
  end
end
