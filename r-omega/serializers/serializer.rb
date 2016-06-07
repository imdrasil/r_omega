require 'erb'

class Serializer
  def initialize(options)
    @options = options
  end

  def serialize
    render_txt
    render_html if verbose?
  end

  def render_txt
    raise NotImplementedError
  end

  def render_html
    raise NotImplementedError
  end

  def verbose?
    @options[:verbose]
  end

  def separate_files?
    @options[:separate]
  end

  def destination_folder
    @options[:destination_path]
  end

  private

  def parse_erb(file, b, vars = '_erbout')
    ERB.new(file, 0, '>', vars).result(b)
  end

  def partial_template_file
    @_partial_template ||= File.open(File.join(App.template_path, partial_template_name)).read
  end

  def template_file
    @_template ||= File.open(File.join(App.template_path, template_name)).read
  end
end
