class CreateCursos < ActiveRecord::Migration[8.0]
  def change
    create_table :cursos do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
