require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'watir'
#browser = Watir::Browser.new(:firefox)  #Si tu as Chrome, supprime (:firefox)
#browser.goto 'google.com'




PAGE_URL = "http://mon-incubateur.com/site_incubateur/incubateurs"

page = Nokogiri::HTML(open(PAGE_URL))

  #
zipcode = page.xpath('//td[2]/p/a')
website = page.xpath('//td[2]/p/span/a')
#http://mon-incubateur.com/site_incubateur/incubateurs
#http://mon-incubateur.com/site_incubateur/incubateur/1000startups-paris-13eme-arrondissement
#
register = {}

#Récupération des infos de la page [nom, code postal, lien menant vers le site de l'incub]
website.each do |incub|
    infos = []
    infos= [zipcode[website.index(incub)].text, "http://mon-incubateur.com#{website[website.index(incub)]['href']}"]
    page2 = Nokogiri::HTML(open(infos[1]))
    incubator = page2.xpath('//div[2]/div/p[2]/a')
    incubator.each do |incub|
        infos << incub['href']
    end

    register[incub.text] = infos
    #puts incub.text
    #puts "http://mon-incubateur.com#{incub['href']}"
    #puts "#{incub.text} - #{zipcode[website.index(incub)].text} - http://mon-incubateur.com#{website[website.index(incub)]['href']}"
end

register.each do |k,v|
    puts "#{k} = #{v}"
end

=begin
PAGE_INCUB="http://mon-incubateur.com/site_incubateur/incubateur/1000startups-paris-13eme-arrondissement"
page2 = Nokogiri::HTML(open(PAGE_INCUB))
incubator = page2.xpath('//div[2]/div/p[2]/a')
#/html/body/div[3]/div[2]/div/p[2]/a
=end




=begin
register={}

cours[0..4].each do |node|
    register[currency[cours.index(node)].text]=node.text
end
array_cours << register
puts array_cours[array_cours.length-1]
sleep(3600)
=end
