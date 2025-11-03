require 'httparty'
require 'json'
require 'dotenv'
Dotenv.load

puts "🔍 DIAGNÓSTICO GEMINI API"
puts "=" * 50

api_key = ENV['GEMINI_API_KEY']
puts "🔑 API Key: #{api_key ? 'PRESENTE' : 'FALTANTE'}"
puts "🔑 Key (inicio): #{api_key[0..10]}..." if api_key

unless api_key
  puts "❌ ERROR: GEMINI_API_KEY no encontrada en .env"
  exit 1
end

# Probar la API directamente
url = "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=#{api_key}"

body = {
  contents: [
    {
      parts: [
        {
          text: "Responde solo con 'FUNCIONA'"
        }
      ]
    }
  ]
}.to_json

begin
  puts "🌐 Enviando prueba a Gemini..."
  response = HTTParty.post(url, headers: {'Content-Type' => 'application/json'}, body: body, timeout: 10)
  
  puts "📡 Status: #{response.code}"
  
  if response.success?
    content = response.dig('candidates', 0, 'content', 'parts', 0, 'text')
    puts "✅ ÉXITO: Gemini responde - #{content}"
  else
    error = response.dig('error', 'message') || "Error #{response.code}"
    puts "❌ FALLA: #{error}"
    puts "📄 Detalles: #{response.body}"
  end
rescue => e
  puts "❌ ERROR: #{e.message}"
end