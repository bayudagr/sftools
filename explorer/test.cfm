<cfoutput>
    <html lang="en">
    <head>
    <meta charset="UTF-8" />
    <title>CodeMirror Vanilla JS Example</title>
    <!-- Include CodeMirror CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.0/codemirror.min.css" />
    <!-- Optionally include a theme -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.0/theme/dracula.min.css" />
    </head>
    <body>
    <textarea id="editor" name="editor" style="height: 300px;"></textarea>

    <!-- Include CodeMirror JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.0/codemirror.min.js"></script>
    <!-- Include a mode for JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.0/mode/javascript/javascript.min.js"></script>

    <script>
        // Initialize CodeMirror on the textarea
        const editor = CodeMirror.fromTextArea(document.getElementById("editor"), {
            mode: "javascript",        // mode / syntax
            lineNumbers: true,         // show line numbers
            theme: "dracula",           // theme
            tabSize: 2,
            indentWithTabs: false
        });

        // Example: get code from the editor
        function getCode() {
            const code = editor.getValue();
            console.log("Current editor content:", code);
            return code;
        }

        // Example: set code programmatically
        editor.setValue("// Hello, world!\nfunction add(a, b) {\n  return a + b;\n}");
    </script>
    </body>
    </html>
</cfoutput>
