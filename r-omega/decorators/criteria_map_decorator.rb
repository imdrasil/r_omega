class CriteriaMapDecorator
  FORMULA_FILES = {
    i: {
      equivalence: 'i_equivalence.html',
      strict_order: 'i_strict_order.html',
      quasy_order: 'i_quasy_order.html'
    },
    p: {
      equivalence: 'p_equivalence.html',
      strict_order: 'p_strict_order.html',
      quasy_order: 'p_quasy_order.html'
    }
  }.freeze

  class << self
    def criteria_type_name(map)
      case map.type
        when :equivalence
          'рівноважні між собою'
        when :strict_order
          'строго впорядковані по важливості'
        when :quasy_order
          'утворюють квазі порядок і розбиті на класи по неспаданню важливості'
      end
    end

    def to_table(map)
      %Q(
        <table style="margin: auto;">
        #{map.map { |row| '<tr>' + row.map { |cel| "<td>#{cel}</td>" }.join(' ') + '</tr>' }.join("\n")}
        </table>
      )
    end

    def I_formula_html(map)
      i_formulas[map.type] ||= File.open(File.join(App.template_path, 'formulas', FORMULA_FILES[:i][map.type])).read
    end

    def P_formula_html(map)
      p_formulas[map.type] ||= File.open(File.join(App.template_path, 'formulas', FORMULA_FILES[:p][map.type])).read
    end

    def formulas
      @formula ||= {}
    end

    def i_formulas
      formulas[:i] ||= {}
    end

    def p_formulas
      formulas[:p] ||= {}
    end
  end
end
