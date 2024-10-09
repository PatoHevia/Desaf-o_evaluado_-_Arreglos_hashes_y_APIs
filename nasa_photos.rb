require 'httparty'
require 'json'

# Método para obtener fotos del rover Curiosity
def obtener_fotos_rover(sol)
  # URL de la API con el número de sol y tu clave de API
  url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=#{sol}&api_key=kte8Qb4eLWhfDdGFZaWsTNgqMuFlQLF9SvXbrjHw"

  # Hacer la solicitud GET
  respuesta = HTTParty.get(url)

  # Comprobar si la solicitud fue exitosa
  if respuesta.code == 200
    # Devolver el cuerpo de la respuesta como un hash
    JSON.parse(respuesta.body)
  else
    puts "Error al obtener fotos: #{respuesta.code}"
    nil
  end
end

# Llamar al método con un número de sol (por ejemplo, 1000)
sol = 1000
fotos = obtener_fotos_rover(sol)

# Mostrar las fotos obtenidas
if fotos && fotos['photos'].any?
  fotos['photos'].each do |foto|
    puts "Foto ID: #{foto['id']}"
    puts "Rover: #{foto['rover']['name']}"
    puts "Toma: #{foto['earth_date']}"
    puts "URL: #{foto['img_src']}"
    puts "-----------------------------"
  end
else
  puts "No se encontraron fotos para el sol #{sol}."
end
