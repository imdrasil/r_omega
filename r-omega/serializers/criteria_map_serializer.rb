require 'serializer'

class CriteriaMapSerializer < Serializer
  def initialize(maps, options = {})
    @maps = Array.wrap(maps)
    super(options)
  end

  def serialize
    render_txt
    render_html if verbose?
  end

  def html_partial_render(map)
    @current_task = map
    ERB.new(partial_template_file, 0, '>').result
  end

  def txt_partial_render(map)
    buf = [map.type, map.alternative_count, map.criteria_count, map.map { |row| row.join(' ') }.join("\n")].join("\n")
    buf += "\n#{map.classes.map(&:count).join(' ')}\n" if map.quasy_order?
    buf
  end

  def render_txt
    txt_partials = @maps.map { |map| txt_partial_render(map) }
    if separate_files?
      txt_partials.each_with_index do |partial, i|
        File.new(File.join(destination_folder, "input_#{i}.txt"), 'w') do |f|
          f.write("1\n")
          f.write(partial)
        end
      end
    else
      File.new(File.join(destination_folder, 'input.txt'), 'w') do |f|
        f.write("#{txt_partials.count}\n")
        f.write(txt_partials.join("\n"))
      end
    end
  end

  def render_html
    partials = @maps.map { |map| html_partial_render(map) }
    if separate_files?
      partials.each_with_index do |partial, i|
        File.open(File.join(destination_folder, "task_#{i}.html"), 'w') do |f|
          @partials = [partial]
          @index = i
          f.write(parse_erb(template_file))
        end
      end
    else
      File.open(File.join(destination_folder, 'tasks.html'), 'w') do |f|
        @partials = partials
        f.write(parse_erb(template_file))
      end
    end
  end

  private

  def partial_template_name
    '_task.html.erb'
  end

  def template_name
    'criteria_map_serializer.html.erb'
  end
end
