require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = "http://mon-incubateur.com/site_incubateur/incubateurs"

page = Nokogiri::HTML(open(PAGE_URL))

name = page.xpath('//p/span/a')    #
zipcode = page.xpath('//td[2]/p/a')
website = page.xpath('//td[2]/p/span/a')
#http://mon-incubateur.com/site_incubateur/incubateurs
#http://mon-incubateur.com/site_incubateur/incubateur/1000startups-paris-13eme-arrondissement
#

website.each do |incub|
    #puts incub.text
    puts "http://mon-incubateur.com#{incub['href']}"

end
