// ✅ Verifica que el archivo se haya cargado
console.log("✅ summernote_ai.js cargado correctamente");

// -------------- CONFIGURAR SUMMERNOTE + BOTÓN IA --------------

// Botón personalizado de IA
function aiContentButton(context) {
  const ui = $.summernote.ui;
  return ui.button({
    contents: '<i class="fa fa-magic"/> Generar IA',
    tooltip: 'Generar contenido con Gemini',
    click: function () {
      console.log("✨ Botón IA presionado");
      generateAiContent(context);
    },
  }).render();
}

// Función que llama al backend Rails
function generateAiContent(context) {
  const title = $('#course_title').val();

  if (!title) {
    alert("🛑 Por favor, introduce primero un título para el curso.");
    return;
  }

  // ✅ CAMBIO CORRECTO: usamos otro nombre (NO prompt)
  const userPrompt = window.prompt("✏️ Instrucciones para Gemini (ejemplo: 'Genera un curso de arte con 3 módulos y actividades')");
  if (!userPrompt) return;

  console.log("📤 Enviando datos a /ai/generate_course_content:", { title, userPrompt });

  context.invoke('editor.insertText', '⏳ Generando contenido con IA...');
  context.invoke('editor.disable');

  fetch('/ai/generate_course_content', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
    },
    // 👇 Aquí enviamos correctamente el prompt
    body: JSON.stringify({ title: title, prompt: userPrompt })
  })
    .then(async (res) => {
      const data = await res.json();
      context.invoke('editor.enable');
      context.invoke('editor.undo');

      if (res.ok && data.content) {
        console.log("✅ Respuesta recibida desde Rails:", data);
        // Inserta el texto HTML generado por Gemini
        context.invoke('editor.pasteHTML', data.content);
      } else {
        console.error("⚠️ Error en la respuesta del servidor:", data);
        alert("⚠️ Error: " + (data.error || "No se recibió contenido válido."));
      }
    })
    .catch((err) => {
      console.error("🚨 Error en fetch:", err);
      context.invoke('editor.enable');
      context.invoke('editor.undo');
      alert("🚨 Error al generar contenido con IA. Revisa la consola para más detalles.");
    });
}

// -------------- INICIALIZAR SUMMERNOTE --------------
document.addEventListener("turbo:load", initializeSummernote);
document.addEventListener("DOMContentLoaded", initializeSummernote);

function initializeSummernote() {
  const editor = $('#summernote');

  if (typeof $ === "undefined") {
    console.error("🚨 jQuery no está cargado.");
    return;
  }

  if (typeof $.fn.summernote === "undefined") {
    console.error("🚨 Summernote no está disponible.");
    return;
  }

  if (editor.length && !editor.data('summernote')) {
    console.log("🟢 Inicializando Summernote con botón de IA...");
    editor.summernote({
      height: 300,
      toolbar: [
        ['ai', ['aiContent']], // 👈 Agregamos el botón IA
        ['style', ['bold', 'italic', 'underline', 'clear']],
        ['para', ['ul', 'ol', 'paragraph']],
        ['insert', ['link', 'hr']],
        ['view', ['fullscreen', 'codeview']]
      ],
      buttons: {
        aiContent: aiContentButton,
      },
    });
  } else {
    console.log("ℹ️ No se encontró #summernote o ya estaba inicializado.");
  }
}
