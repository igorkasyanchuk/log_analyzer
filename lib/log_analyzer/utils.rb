module LogAnalyzer
  class Utils
    DANGER_DEFAULT      = 800 # ms
    WARNING_DEFAULT     = 400 # ms
    INFO_DEFAULT        = 100 # ms
    DEFAULT_PATH_WIDTH  = 60
    PARTIAL_LABEL       = " P ".on_green.black.freeze
    VIEW_LABEL          = " V ".on_yellow.black.freeze

    def Utils.find_type(view)
      if view.split('/'.freeze).last[0] == '_'.freeze
        LogAnalyzer::Configuration::PARTIALS
      else
        LogAnalyzer::Configuration::VIEWS
      end
    end

    def Utils.type_label(type)
      if type == LogAnalyzer::Configuration::PARTIALS
        PARTIAL_LABEL
      else
        VIEW_LABEL
      end
    end

    def Utils.avg_label(avg)
      str = avg.to_s
      if avg > DANGER_DEFAULT
        str.white.on_red
      elsif avg > WARNING_DEFAULT
        str.red
      elsif avg > INFO_DEFAULT
        str.yellow
      else
        str.green
      end
    end

    def Utils.path_to_display(path, short: false, length: DEFAULT_PATH_WIDTH)
      if short
        PathShortener.shrink(path, max: length.last)
      else
        path[length]
      end
    end

    def Utils.report_name(extension)
      "report-log-analyzer-#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}.#{extension}"
    end

  end
end