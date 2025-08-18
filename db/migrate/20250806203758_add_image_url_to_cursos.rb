class AddImageUrlToCursos < ActiveRecord::Migration[8.0]
  def change
    add_column :cursos, :image_url, :string
  end
end
