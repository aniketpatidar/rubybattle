import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static targets = ["editor"];

  connect() {
    this.codeEditor = document.querySelector(`#code-editor`);
    this.textArea = CodeMirror.fromTextArea(this.editorTarget, {
      mode: "ruby",
      lineNumbers: true,
      indentUnit: 2,
      tabSize: 2,
      lineWrapping: true,
      autofocus: true
    });

    const methodTemplate = this.codeEditor.dataset.methodTemplate.replaceAll("\\n", "\n");
    this.textArea.setValue(methodTemplate);
    this.roomID = this.codeEditor.dataset.roomId;
    this.consumer = createConsumer();
    this.subscription = this.consumer.subscriptions.create(
      { channel: "CollaborationChannel", room: this.roomID },
      {
        received: this.handleReceivedData.bind(this)
      }
    );
    this.setEditorSize('550px');
    this.textArea.on("change", this.handleEditorChange.bind(this));
  }

  setEditorSize(height) {
    this.textArea.getWrapperElement().style.height = height;
  }

  handleReceivedData(data) {
    if (this.getEditorCode() !== data.content) {
      this.textArea.setValue(data.content);
    }
  }

  handleEditorChange() {
    const code = this.getEditorCode();
    this.subscription.send({ content: code });
  }

  getEditorCode() {
    return this.textArea.getValue();
  }

  run() {
    const code = this.getEditorCode();
    const id = this.codeEditor.dataset.challengeId;
    try {
      fetch('/execute_ruby', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ code, id }),
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('Response was not ok');
        }
        return response.json();
      })
      .then(result => {
        const outputElement = document.getElementById('executionResult');
        if (result.error) {
          outputElement.innerText = 'Error: ' + result.error;
        } else {
          let output = '';
          for (const [input, details] of Object.entries(result.output)) {
            output += `Test case: ${input}\n`;
            output += `Expected: ${details.expected}\n`;
            output += `Actual: ${details.actual}\n`;
            output += `Passed: ${details.passed ? '✅' : '❌'}\n\n`;
          }
          outputElement.innerText = output || 'No output';
        }
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
