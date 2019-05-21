module CxExtractor
  # utils for cx_extractor
  module Utils
    def line_block_distribute(lines)
      block_distribution = []
      index_distribution = lines.map(&:length)
      (0...(lines.length - balck_width + 1)).each do |i|
        word_num = 0
        (0...balck_width).each do |j|
          word_num += index_distribution[i + j]
        end
        block_distribution[i] = word_num
      end
      block_distribution
    end

    def find_surge(block_distribution, start, threshold)
      ((start + 1)...block_distribution.length - 3).each do |index|
        if block_distribution[index] > threshold && (
           block_distribution[index + 1] > 0 ||
           block_distribution[index + 2] > 0 ||
           block_distribution[index + 3] > 0)
          return index
        end
      end
      -1
    end

    def find_dive(block_distribution, surge_point)
      ((surge_point + 1)...(block_distribution.size - 2)).each do |index|
        if block_distribution[index].zero? &&
           block_distribution[index + 1].zero?
          return index - 1
        end
      end
      block_distribution.size - 1
    end

    def get_clean_text(dom)
      # remove html comment
      html = dom.clone
      html.gsub!(/<!--.*?(.|\n)*?-->/, "\n")
      # remove javascript
      html.gsub!(%r{<script.*?>.*?(.|\n)*?</script>}, "\n")
      # remove a
      html.gsub!(%r{<a[\t|\n|\r|\f].*?>.*?</a>}, '')
      # remove css
      html.gsub!(%r{<style.*?>.*?(.|\n)*?</style>}, "\n")
      # remove tag
      html.gsub!(/<.*?(.|\n)*?>/, '')
      replace_special_char(html)
    end

    def replace_special_char(str)
      str.gsub!('&#8226;', '·')
      str.gsub!('&amp;', '&')
      str.gsub!('&nbsp;', ' ')
      str.gsub!('&copy;', '@')
      str.gsub!("\r\n|\r", "\n")
      str
    end
  end
end
