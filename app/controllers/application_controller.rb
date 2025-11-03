class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
before_action :load_cursos
  private

  def load_cursos
    @cursos = Curso.all
end

  def after_sign_in_path_for(resource)
    cursos_path
  end

   def after_sign_out_path_for(resource_or_scope)
    # Redirige a la ruta de inicio de sesión de los profesores
    new_profesor_session_path
  end
# Método helper para verificar si el usuario es un Profesor (y por ende, administrador)
  # Esto estará disponible en todos los controladores y vistas
  def current_profesor_admin?
    # Devise proporciona el helper 'profesor_signed_in?' y 'current_profesor'
    profesor_signed_in?
  end
  helper_method :current_profesor_admin? # Hace que el método esté disponible en las vistas

  private

  # Método que usamos como filtro 'before_action'
  def require_profesor
    # Redirige si el usuario NO es un Profesor logueado
    unless current_profesor_admin?
      redirect_to root_path, alert: "Acceso no autorizado. Solo Profesores tienen permiso."
    end
  end
end