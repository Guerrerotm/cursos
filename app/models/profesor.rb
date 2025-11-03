class Profesor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  # devise agrega la parte de autenticación
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cursos, dependent: :destroy
end
