require 'rubygems'
require 'nokogiri'
require 'open-uri'



#récupère l'adresse email à partir de l'url d'une mairie
def get_the_email_of_a_townhal_from_its_webpage(url)

    page = Nokogiri::HTML(open(url))

    e_mails = page.css("tr > td.style27 > p.Style22") #recherche par CSS la section Adresse email
    e_mails.each{|adr|

        #parmis les infos collecter, recherche les données contenant le caractère @ pour déterminer si la donnée = email
        if adr.text.include? "@"
            return adr.text
        end
    }
end


def get_all_the_urls_of_val_doise_townhalls(url)
    page = Nokogiri::HTML(open(url))
    list_url={}
    website = page.xpath('//p/a')   #Recherche tous le code html des villes

    website.each do |node|
        infos = []
        url = "http://annuaire-des-mairies.com"+node['href'][1...node['href'].length]       #compléter l'URL de chaque mairie
        infos <<  url
        infos << get_the_email_of_a_townhal_from_its_webpage(url)
        list_url[node.text]=infos       #Hash{ Ville => [URL_mairie, email_mairie]}
	    #{node['href'][1...node['href'].length]}"

	end

    list_url.each do |city,infos|
        puts "#{city} : #{infos}"
    end


end

URL_VAUREAL = "http://annuaire-des-mairies.com/95/vaureal.html"
URL_VAL_OISE= "http://annuaire-des-mairies.com/val-d-oise.html"
url = "http://annuaire-des-mairies.com/95/mours.html"

#get_the_email_of_a_townhal_from_its_webpage()

get_all_the_urls_of_val_doise_townhalls(URL_VAL_OISE)
