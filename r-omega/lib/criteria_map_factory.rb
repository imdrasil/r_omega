class CriteriaMapFactory
	attr_accessor :array
	MAX_CRITERIA_VALUE = 20

  def initialize(file_path)
  	@file = File.new(file_path, 'r')
  	@amount = @file.gets.chomp.to_i
  	@array = create
  	@file.close
  end

  def create
  	@amount.times.map do
  		@type = @file.gets.chomp.to_sym
  		@m = @file.gets.chomp.to_i
  		@n = @file.gets.chomp.to_i
  		@range = [0...@n]
  		
  		@hand_mode = @file.gets.chomp.to_i
  		if @hand_mode == 1
  			@map = @m.times.map { @file.gets.split.map(&:to_i) }
			else
				@positive = @file.gets.chomp.to_i
				@map = @m.times.map { @n.times.map { rand(0..MAX_CRITERIA_VALUE) } }
				if @positive == 1
					i = rand(0...(@m - 1))
					equalize(i)
				end
  		end
  		if @type == :quasy_order
  			@range = @file.gets.split.map(&:to_i)
  			_start = 0
  			@range.map! do |s|
  				_start += s
  				(_start-s)..._start
  			end
  		end
			CriteriaMap.new(type: @type, map: @map, classes: @range)
  	end
  end

  def equalize(i)
  	@range.each do |r|
  		sum_1 = 0
  		sum_2 = 0
  		r.each do |j|
  			sum_1 += @map[i][j]
  			sum_2 += @map[i + 1][j]
  			diff = sum_1 - sum_2
  			if diff > 0
  				@map[i + 1][r.end - 1] += diff
  			else
  				@map[i][r.end - 1] -= diff
  			end
  		end
  	end
  end
end
