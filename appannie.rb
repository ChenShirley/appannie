require 'open-uri'
require 'nokogiri'
web_data = open('http://www.appannie.com/apps/ios/app/facebook/')
doc = Nokogiri.HTML(web_data)

achievements = doc.xpath("//td[@class='count']")
achievements.each { |badge_element| puts badge_element.text }


require 'nokogiri'
require 'open-uri'
module CodeBadges
  # This class get the user account as an input
  # return a hash of user's badges information
  class CodecademyBadges
    TITLE_XPATH = "//div[@class = 'grid-row']//h5[@class = 'margin-top--1']"
    DATE_XPATH  = "//small[@class = 'text--ellipsis']"
    USERS_URL = 'http://www.codecademy.com/users'
    ACHIEVEMENTS_DIR = 'achievements'

    def self.get_badges(username)
      doc = get_html(username)
      titles = get_titles(doc)
      dates = get_dates(doc)
      integrate(titles, dates)
    end

    def self.get_html(username)
      url = "#{USERS_URL}/#{username}/#{ACHIEVEMENTS_DIR}"
      Nokogiri::HTML(open(url))
    end

    def self.get_titles(document)
      titles = document.xpath(TITLE_XPATH)
      titles.map { |t| t.text }
    end

    def self.get_dates(document)
      dates = document.xpath(DATE_XPATH)
      dates.map { |d| Date.parse(d) }
    end

    def self.integrate(titles, dates)
      badge_array = titles.each_with_index.map do |_, index|
        [titles[index], dates[index]]
      end
      Hash[badge_array]
    end
  end
end
