require "uri"
require "net/http"
require "json"

#Quiero ocupar el punto que tenía en esta prueba porfa
# 1. Crear el método request que reciba una url y el api_key y devuelva el hash con los resultados.
# Concatenar la API Key en la siguiente url https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY

def request(url, api_key)
url = URI("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY")

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Get.new(url)
response = https.request(request)
JSON.parse(response.read_body)
end

body = request(url)


# Crear un método llamado buid_web_page que reciba el hash de respuesta con todos
# los datos y construya una página web. Se evaluará la página creada y tiene que tener
# este formato:

def buid_web_page(data)
    imagen = data['photos'].map{|x| x['img_src']}
    doc_html = "<html>\n<head>\n</head>\n<body>\n\t<ul>\n"
    imagen.each do |photo|
        doc_html += "\t\t<li>\n\t\t\t<img src='#{photo}'>\n\t\t</li>\n"
        end
    doc_html += "\t</ul>\n</body>\n</html>"
    File.write('photos.html', doc_html)
end
buid_web_page(body)

 
# Pregunta bonus: Crear un método photos_count que reciba el hash de respuesta y
# devuelva un nuevo hash con el nombre de la cámara y la cantidad de fotos