# кількість задач
# кількість альтернатив
# кількість критеріїв
# тип
# розбиття клсасів
# кількість ненульових елементів
#====
# матриця ручна
require 'optparse'
require_relative 'initializer'

def parse_params
  options = {}
  OptionParser.new do |opts|
    opts.banner = 'Usage: generate.rb [options]'

    opts.on("-v", "--[no-]verbose", "Run verbosely") do |f|
      options[:verbose] = f
    end
    opts.on('-s', '--separate', 'Writes each task to separate file') { |f| options[:separate] = f }
  end.parse!
  options[:file_name] = ARGV[0]
  options[:destination_path] = ARGV[1] || App.root
end

options = parse_params
factory = CriteriaMapFactory.new(options[:file_name])
serializer = CriteriaMapSerializer.new(factory.create, options)
puts serializer.serialize


