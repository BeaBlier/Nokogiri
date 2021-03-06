require 'rubygems'
require 'nokogiri'
require 'open-uri'




def get_cours_cryptocurrencies(url)
    page = Nokogiri::HTML(open(url))

    array_cours=[]

    #Récupère les infos HTML de chaque cryptomonnaie et de leur cours
    currency=page.xpath('//td[2]/a')
    cours = page.xpath('//td[5]/a')

    #QUITTER LE PROGRAMME ==> CTRL+C
    while true
        #initialisation du hash
        register={}

          #J'ai limité les 5 premières cryptomonnaies pour que ça soit lisible sur la console. Pour afficher toutes les monnaies, effacer [0..4]
        cours[0..4].each do |node|
            #récupère dans le hash le nom de la cryptomonnaie => son cours
            register[currency[cours.index(node)].text]=node.text
        end

        array_cours << register     #on balance tout ça dans un array

        #Je puts seulement la dernière case de mon array (cours à instant T) au lieu de surcharger la console avec un puts array_cours qui va me renvoyer l'historique + cours à instant T
        puts array_cours[array_cours.length-1]
        sleep(3600)
    end
end

PAGE_URL = "https://coinmarketcap.com/all/views/all/"
get_cours_cryptocurrencies(PAGE_URL)
