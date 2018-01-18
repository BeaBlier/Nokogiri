require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = "https://coinmarketcap.com/all/views/all/"

page = Nokogiri::HTML(open(PAGE_URL))
i=0
array_cours=[]
cours = page.xpath('//td[5]/a')#'/a')#[@class="price"]')
currency=page.xpath('//td[2]/a')
while i<3
    register={}

    cours[0..4].each do |node|
        register[currency[cours.index(node)].text]=node.text
        array_cours << register

        #{node['href'][1...node['href'].length]}"
        #puts "#{currency[cours.index(node)].text} : #{node.text}"
        #puts node.text

    end

    sleep(3)
    i += 1
end
puts array_cours
=begin
array_cours.each do |k,v|
    puts "#{k} : #{v}"
end
=end
