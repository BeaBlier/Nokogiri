require 'rubygems'
require 'nokogiri'
require 'open-uri'



#récupère l'adresse email à partir de l'url d'une mairie, par exemple celle de Vauréal
def get_the_email_of_a_townhal_from_its_webpage(url)#(town)
    #town.downcase!
    #PAGE_URL = PAGE_URL+"/#{town}.html"
    page = Nokogiri::HTML(open(url))

    e_mails = page.css("tr > td.style27 > p.Style22")       #ou page.css("div#references a")
    e_mails.each{|adr|

        c=adr.text.chars #{}"#{adr.attribute()} => #{adr.text}"
        if c.include? "@"
            c.join
            puts adr.text
        end
    }
end

#http://annuaire-des-mairies.com/val-d-oise.html
def get_all_the_urls_of_val_doise_townhalls(url)
    page = Nokogiri::HTML(open(url))
    list_url={}
    website = page.xpath('//p/a')

    website.each do |node|
        list_url[node.text]="http://annuaire-des-mairies.com"+node['href'][1...node['href'].length]
	    #{node['href'][1...node['href'].length]}"

	end
    list_url.each do |city,url|
        puts "#{city} : #{url}"
    end
end



URL_VAUREAL = "http://annuaire-des-mairies.com/95/vaureal.html"
URL_VAL_OISE= "http://annuaire-des-mairies.com/val-d-oise.html"
url = "http://annuaire-des-mairies.com/95/mours.html"

get_the_email_of_a_townhal_from_its_webpage(url)

get_all_the_urls_of_val_doise_townhalls(URL_VAL_OISE)
