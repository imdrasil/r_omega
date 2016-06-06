class RelationDecorator
  class << self
    def criteria_type_name(rel)
      case rel.type
        when :equivalence
          'рівноважні між собою'
        when :strict_order
          'строго впорядковані по важливості'
        when :quasy_order
          'утворюють квазі порядок і розбиті на класи по неспаданню важливості'
      end
    end

    def to_table(rel)
      %Q(
        <table>
        #{rel.graph.map { |row| '<tr>' + row.map { |cel| "<td>#{cel}</td>" } + '</tr>' }.join("\n")}
        </table>
      )
    end
  end
end
