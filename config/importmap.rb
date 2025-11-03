# Pin npm packages by running ./bin/importmap

# Mantenemos los pins que son necesarios para Rails (Turbo y Stimulus)
pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# ELIMINAMOS/COMENTAMOS ESTOS PINS
# Son cargados por CDN, y cargarlos aquí causa los errores 404 y de integridad.
# pin "bootstrap", integrity: "sha384-Hea0Yk7N2rQhmxzzIGikclw/jBEhpCDFFXi+rlgF1qZtC7eAazBGapuqKzAe6yXQ" # @5.3.7
# pin "@popperjs/core", to: "@popperjs--core.js", integrity: "sha384-bfekMOfeUlr1dHZfNaAFiuuOeD7r+Qh45AQ2HHJY7EAAI4QGJ6qx1Qq9gsbvS+60" # @2.11.8
# pin "jquery", to: "jquery.min.js", preload: true 
# pin "summernote", to: "summernote-bs5.min.js", preload: true