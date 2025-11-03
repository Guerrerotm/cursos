class CreateProfesors < ActiveRecord::Migration[8.0]
  def change
    create_table :profesors do |t|
      t.string :nombre
      t.string :email

      t.timestamps
    end
  end
end
