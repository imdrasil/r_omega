require_relative 'initializer'

cm = CriteriaMap.new(type: :quasy_order,
                     map: [[5, 7, 3, 2, 7, 4],
                           [5, 4, 3, 2, 3, 8],
                           [6, 3, 7, 9, 10, 12]],
                     classes: [0..1, 2..4, 5..5])
puts cm.print
ro = ROmega.new(cm)
puts ro.print
