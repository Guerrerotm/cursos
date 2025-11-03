class AddDeviseFieldsToProfesors < ActiveRecord::Migration[8.0]
  def change
    ## Database authenticatable
    # La columna :email ya existe, así que no la agregamos de nuevo
    # add_column :profesors, :email, :string, null: false, default: ""
    add_column :profesors, :encrypted_password, :string, null: false, default: ""

    ## Recoverable
    add_column :profesors, :reset_password_token,   :string
    add_column :profesors, :reset_password_sent_at, :datetime

    ## Rememberable
    add_column :profesors, :remember_created_at, :datetime

    ## Indexes
    # Si el índice sobre :email ya existe, comenta esta línea también
    # add_index :profesors, :email, unique: true
    add_index :profesors, :reset_password_token, unique: true
  end
end
