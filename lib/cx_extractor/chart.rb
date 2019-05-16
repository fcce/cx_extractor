require 'gruff'
module CxExtractor
  # make a chart for block_distribution
  module Chart
    def cal_labels(distribution)
      labels = {}
      index_distribution_length = distribution.length
      [0, 1, 2, 4, 8].each do |i|
        v = index_distribution_length / (2**i)
        labels[v] = v.to_s
      end
      percentile_seventy_five = index_distribution_length * 3 / 4
      labels[percentile_seventy_five] = percentile_seventy_five.to_s
      labels
    end

    def cal_color(index)
      if index % 2 > 0
        '#85AF99'
      else
        '#E5E5E5'
      end
    end

    def chart(distribution, chart_points, filename = chart_file_name)
      g = Gruff::Line.new
      g.theme = chart_theme
      g.labels = cal_labels(distribution)
      chart_points.unshift 0
      gruff_line(g, chart_points)
      g.hide_legend = true
      g.minimum_value = 0
      g.write(filename)
    end

    def gruff_line(gruff, chart_points)
      start_point = end_point = 0
      chart_points.each_with_index do |break_point, index|
        start_point = break_point
        end_point = chart_points[index + 1] || distribution.length - 1
        gruff.dataxy('line' + break_point.to_s,
                     (start_point..end_point).to_a,
                     distribution[start_point..end_point], cal_color(index))
      end
    end
  end
end
