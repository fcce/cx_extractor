# configure
module CxExtractor
  DEFAULTS = {
    threshold: 80,
    balck_width: 3,
    explore_parent: true,
    chart_distribution: false,
    chart_file_name: 'distribution.png',
    chart_theme: {
      marker_color: '#AEA9A9',
      font_color: 'black',
      background_colors: 'white'
    }
  }.freeze

  class << self
    def options
      @options ||= DEFAULTS.dup
    end

    attr_writer :options

    def configure
      yield self
    end
  end

  DEFAULTS.each do |k, _v|
    define_singleton_method "#{k}=" do |value|
      options.merge!(k => value)
    end

    define_singleton_method k do
      options[k]
    end
  end
end
