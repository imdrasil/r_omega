require 'serializer'

class CriteriaMapSerializer < Serializer
  def initialize(maps, options = {})
    @maps = maps.is_a?(Array) ? maps : [maps]
    super(options)
  end

  def html_partial_render(map)
    @current_task = map
    html = parse_erb(partial_template_file, binding)
    @index += 1
    html
  end

  def txt_partial_render(map)
    buf = [map.type, map.alternative_count, map.origin_criteria_count,
           map.origin_map.map { |row| row.join(' ') }.join("\n")].join("\n")
    buf += "\n#{map.classes.map(&:count).join(' ')}" if map.quasy_order?
    buf
  end

  def render_txt
    txt_partials = @maps.map { |map| txt_partial_render(map) }
    if separate_files?
      txt_partials.each_with_index do |partial, i|
        File.open(File.join(destination_folder, "input_#{i}.txt"), 'w') do |f|
          f.write("1\n")
          f.write(partial)
        end
      end
    else
      File.open(File.join(destination_folder, 'input.txt'), 'w') do |f|
        f.write("#{txt_partials.count}\n")
        f.write(txt_partials.join("\n"))
      end
    end
  end

  def render_html
    @index = 0
    partials = @maps.map { |map| html_partial_render(map) }
    if separate_files?
      partials.each_with_index do |partial, i|
        File.open(File.join(destination_folder, "task_#{i}.html"), 'w') do |f|
          @partials = [partial]
          f.write(parse_erb(template_file, binding))
        end
      end
    else
      File.open(File.join(destination_folder, 'tasks.html'), 'w') do |f|
        @partials = partials
        f.write(parse_erb(template_file, binding))
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
