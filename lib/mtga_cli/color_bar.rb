#
# Brint text in a color bar
#
require 'colorize'

module MtgaCli
  class ColorBar
    WIDTH=80

    def self.create(text, percent)
      padded = ' ' + text.ljust(WIDTH - 1)
      fg_width = (WIDTH * (percent / 100)).round
      bg_width = WIDTH - fg_width

      fg_string = padded[0, fg_width]
      bg_string = padded[fg_width, WIDTH] || ''

      fg = fg_color(percent)
      bg = bg_color(percent)

      fg_string.colorize(background: fg) +
        bg_string.colorize(background: bg)
    end

    def self.bg_color(percent)
      case percent
      when 100.0 then :blue
      when 90.0..100.0 then :green
      when 50.0..90.0 then :yellow
      else
        :red
      end
    end

    def self.fg_color(percent)
      case percent
      when 100 then :light_blue
      when 90..100 then :light_green
      when 50..90 then :light_yellow
      else
        :light_red
      end
    end
  end
end
