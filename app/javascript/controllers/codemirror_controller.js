import { Controller } from "@hotwired/stimulus"
// import CodeMirror from "codemirror"
// import "codemirror/mode/ruby/ruby"
// import "codemirror/theme/monokai.css"

export default class extends Controller {
  static targets = ["editor"];

  connect() {
    this.editor = CodeMirror.fromTextArea(this.editorTarget, {
      mode: "ruby",
      theme: "monokai",
      lineNumbers: true
    });
    this.setEditorSize('1525px', '400px');
    this.setOutputSectionHeight('1525px', '200px');
  }

  setEditorSize(width, height) {
    this.editor.getWrapperElement().style.width = width;
    this.editor.getWrapperElement().style.height = height;
    this.editor.refresh();
  }

  setOutputSectionHeight(width, height) {
    const outputSection = document.getElementById('output');
    if (outputSection) {
      outputSection.style.width = width;
      outputSection.style.height = height;
    }
  }

  getEditorCode() {
    return this.editor.getValue();
  }

  run() {
    const code = this.getEditorCode();
    try {
      fetch('/execute_ruby', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ code }),
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('Response was not ok');
        }
        return response.json();
      })
      .then(result => {
        console.log(result);
        document.getElementById('executionResult').innerText = result.output || 'No output';
      })
      .catch(error => {
        console.error('Error running code:', error);
        document.getElementById('executionResult').innerText = 'Error: ' + error.message;
      });
    } catch (error) {
      console.error('Error running code:', error);
      document.getElementById('executionResult').innerText = 'Error: ' + error.message;
    }
  }
}
