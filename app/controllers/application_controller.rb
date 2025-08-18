class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
before_action :load_cursos
  private

  def load_cursos
    @cursos = Curso.all
end
end