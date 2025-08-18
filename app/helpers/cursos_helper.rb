# app/helpers/cursos_helper.rb
require 'nokogiri'

module CursosHelper
  def generate_table_of_contents(html_content)
    # Parsear el HTML con Nokogiri para encontrar los encabezados
    doc = Nokogiri::HTML::DocumentFragment.parse(html_content)
    headers = doc.css('h1, h2, h3, h4, h5, h6')

    return '' if headers.empty?

    # Generar el HTML del índice
    toc = '<div class="table-of-contents"><strong>Índice de Contenido</strong><ol>'
    headers.each_with_index do |header, index|
      # Crear un ID único para cada encabezado para poder enlazarlo
      id = "toc-header-#{index}"
      header['id'] = id

      # Agregar el elemento del índice
      toc += "<li><a href='##{id}'>#{header.text}</a></li>"
    end
    toc += '</ol></div>'

    # Devolver el índice y el contenido modificado (con los IDs)
    [toc.html_safe, doc.to_html.html_safe]
  end
end
