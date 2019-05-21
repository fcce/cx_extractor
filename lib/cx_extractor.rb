require 'cx_extractor/version'
require 'cx_extractor/config'
require 'cx_extractor/chart'
require 'cx_extractor/utils'
require 'nokogiri'
require 'typhoeus'
require 'charlock_holmes'
# nodoc
module CxExtractor
  extend Chart if explore_parent
  extend Utils
  class << self
    TITLE_REGEXP = %r{<title>(.*?)</title>}.freeze

    def article(html)
      ctext = get_clean_text(html)
      lines = ctext.split("\n").map(&:strip)
      block_distribution = line_block_distribute(lines)
      content = get_content(lines, block_distribution)
      content = get_content_by_tag(html, content) if explore_parent
      # content.gsub("\n",'') if remove_newline
      content.squeeze.strip
    end

    def get_title(html)
      matcher = TITLE_REGEXP.match(html) || []
      matcher[1]
    end

    def get_content(lines, block_distribution)
      from_line = to_line = 0
      content = chart_points = []
      loop do
        from_line, to_line = get_contect_block(block_distribution, to_line)
        content += lines[from_line..to_line]
        break if from_line < 0

        chart_points += [from_line, to_line]
      end
      if chart_distribution && !chart_points.empty?
        chart(block_distribution, chart_points)
      else
        warn 'there is no content for the web page, cannot chart'
      end
      content.join("\n")
    end

    def get_contect_block(block_distribution, to_line)
      from_line = find_surge(block_distribution, to_line, threshold)
      to_line = find_dive(block_distribution, from_line)
      [from_line, to_line]
    end

    def get_content_by_tag(html, block_content)
      doc =  Nokogiri::HTML(html)
      p_doms = doc.css('p')
      ptext = []
      p_doms.each do |p_dom|
        ptext << p_dom.parent if block_content.include?(p_dom.text)
      end
      max_p = ptext.max_by { |i| ptext.count(i) }
      get_clean_text(max_p.to_s).split("\n").map(&:strip).join(
        "\n"
      ).squeeze
    end
  end
end
