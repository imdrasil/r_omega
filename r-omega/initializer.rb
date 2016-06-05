class App
  class << self
    def root
      @root ||= File.dirname(__FILE__)
    end

    def template_path
      @template_path = File.join(root, 'templates')
    end

    def load
      %w(lib models workers).each do |d|
        $LOAD_PATH.unshift File.join(File.dirname(__FILE__), d)
        Dir.glob("#{d}/**/*.rb").each do |f|
          require File.expand_path(f, root)
        end
      end
    end
  end
end

App.load
