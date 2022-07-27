# Created 7/27/2022 by Jake McCann
require 'json'

# Created 7/27/2022 by Jake McCann
#
# Used to transfer news data without having to pass around a Finnhub Object
class NewsArticle
  attr_accessor :category, :time, :headline, :image, :source, :summary, :url
  def initialize category, time, headline, image, source, summary, url
    @category, @time, @headline, @image, @source, @summary, @url = category, time, headline, image, source, summary, url
  end
end

module StocksHelper

  # Created 7/27/2022 by Jake McCann
  #
  # Fetches 5 most recent general news articles from Finnhub
  def self.GeneralNews
    desired_articles = FinnhubClient.market_news('general').first(5)
    desired_articles.map! do |finnhub_article|
      human_time = Time.at(finnhub_article.datetime)
      NewsArticle.new(finnhub_article.category,human_time, finnhub_article.headline, finnhub_article.image,
                      finnhub_article.source,finnhub_article.summary, finnhub_article.url)
    end
  end

end