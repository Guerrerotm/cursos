// Importaciones principales de Rails
import "@hotwired/turbo-rails"
import "controllers"

// ✅ Verifica que jQuery y Summernote se carguen por CDN en tu layout

console.log("✅ summernote integrado correctamente");

// Función para generar contenido con IA
function generateAiContent(context) {
  const title = $('#course_title').val(); 
  if (!title) {
    alert("🛑 Por favor, introduce primero un título para el curso.");
    return;
  }

  const prompt = prompt("Instrucciones para Gemini:");
  if (!prompt) return;

  context.invoke('editor.pasteHTML', '<p><i class="fa fa-spinner fa-spin"></i> Generando contenido con IA...</p>');
  context.invoke('editor.disable');

  fetch('/ai/generate_course_content', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    },
    body: JSON.stringify({ title, prompt })
  })
  .then(res => res.json())
  .then(data => {
    context.invoke('editor.enable');
    context.invoke('editor.undo');
    context.invoke('editor.pasteHTML', data.content);
  })
  .catch(err => {
    console.error("🚨 Error al generar contenido:", err);
    context.invoke('editor.enable');
    context.invoke('editor.undo');
    alert("🚨 Error al generar contenido.");
  });
}

// 🧠 Botón personalizado de IA
function aiContentButton(context) {
  const ui = $.summernote.ui;
  return ui.button({
    contents: '<i class="fa fa-magic"></i> Generar IA',
    tooltip: 'Generar contenido con Gemini',
    click: function() {
      console.log("✨ Botón IA presionado");
      generateAiContent(context);
    }
  }).render();
}

// Inicializa Summernote cuando Turbo carga
document.addEventListener("turbo:load", () => {
  if ($('#summernote').length && !$('#summernote').data('summernote')) {
    console.log("🟢 Inicializando Summernote con IA...");
    $('#summernote').summernote({
      height: 300,
      toolbar: [
        ['ai', ['aiContent']],
        ['style', ['bold', 'italic', 'underline', 'clear']],
        ['para', ['ul', 'ol', 'paragraph']],
        ['insert', ['link', 'hr']],
        ['view', ['fullscreen', 'codeview']]
      ],
      buttons: { aiContent: aiContentButton }
    });
  }
});
