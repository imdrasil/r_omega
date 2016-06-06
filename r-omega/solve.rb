require 'optparse'
require_relative 'initializer'

def parse_params
  options = {}
  OptionParser.new do |opts|
    opts.banner = 'Usage: solve.rb [options]'

    opts.on("-v", "--[no-]verbose", "Run verbosely") do |f|
      options[:verbose] = f
    end
    opts.on('-s', '--separate', 'Writes each task to separate file') { |f| options[:separate] = f }
    opts.on('-d', '--directory', 'Use as input all files from directory') { |f| options[:directory] = f }
  end.parse!
  options[:file_name] = ARGV[0]
  options[:destination_path] = ARGV[1] || App.root
  options
end

options = parse_params
criteria_maps = CriteriaMap.build_series(options)
r_omegas = criteria_maps.map { |map| ROmega.new(map) }
serializer = ROmegaSerializer.new(r_omegas, options)
serializer.serialize
