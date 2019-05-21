# frozen_string_literal: true

RSpec.describe CxExtractor do
  it 'has a version number' do
    expect(CxExtractor::VERSION).not_to be nil
  end

  it 'content' do
    Typhoeus::Config.user_agent = 'Mozilla/5.0 (compatible; Baiduspider/2.0;+http://www.baidu.com/search/spider.html'
    options = { followlocation: true }
    url = 'https://finance.sina.com.cn/roll/2019-05-21/doc-ihvhiqay0150502.shtml'
    response = Typhoeus.get(url, options)
    body = response.body
    detection = CharlockHolmes::EncodingDetector.detect(body)
    utf8_encoded_content = CharlockHolmes::Converter.convert body, detection[:encoding], 'UTF-8'
    content = CxExtractor.article(utf8_encoded_content)
    article_content = '作为门户时代的王者，百度想在腾讯、阿里和头条等山头林立的移动互联世界重新打下一片江山，转型移动生态，还有机会吗'
    expect(content).to include(article_content)
  end
end
