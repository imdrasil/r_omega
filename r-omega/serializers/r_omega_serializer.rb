require 'serializer'
# TODO: add book name in template
class ROmegaSerializer < Serializer
  def initialize(relations, options)
    @relations = relations
    super(options)
  end

  def render_txt
    partials = @relations.map { |rel| txt_partial_render(rel) }
    if separate_files?
      partials.each_with_index do |partial, i|
        File.open(File.join(destination_folder, "output_#{i}.txt"), 'w') { |f| f.write(partial) }
      end
    else
      File.open(File.join(destination_folder, 'output.txt'), 'w') do |f|
        f.write(partials.each_with_index.map { |rel, i| "Завдання #{i + 1}\n#{rel}" }.join("\n"))
      end
    end
  end

  def render_html
    partials = @relations.each_with_index.map { |rel, i| html_partial_render(rel, i) }
    if separate_files?
      partials.each do |partial|
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

  def txt_partial_render(rel)
    rel.graph.map { |row| row.join(' ') }.join("\n")
  end

  def html_partial_render(rel, i)
    @current_relation = rel
    @index = i
    parse_erb(partial_template_file, binding)
  end

  private

  def partial_template_name
    '_relation.html.erb'
  end

  def template_name
    'r_omega_serializer.html.erb'
  end
end
