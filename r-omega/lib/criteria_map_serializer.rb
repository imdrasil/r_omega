require 'erb'

class CriteriaMapSerializer
  TEMPLATES = {
    partial: '_task.html.erb',
    full: 'criteria_map_serializer.html.erb'
  }.freeze

  def initialize(maps, options = {})
    @maps = Array.wrap(maps)
    @options = options
  end

  def serialize
    html_render(@maps[0])
  end

  def html_render(map)
    @current_task = map
    ERB.new(partial_template_file, 0, '>').result
  end

  def txt_render(map)

  end

  def verbose?
    @options[:verbose]
  end

  private

  def partial_template_file
    @_partial_template = File.open(File.join(App.template_path, TEMPLATES[:partial])).read
  end

  def template_file
    @_template = File.open(File.join(App.template_path, TEMPLATES[:full])).read
  end
end
