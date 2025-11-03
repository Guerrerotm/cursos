class AddProfesorIdToCursos < ActiveRecord::Migration[8.0]
  def change
    add_reference :cursos, :profesor, foreign_key: true

  end
end
