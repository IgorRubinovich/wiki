<html>
  <head>
    <title>Wiki {{name}}</title>
    <link href="{{{contentRoot}}}/style.css" rel="stylesheet" type="text/css">
  </head>

  <body>
    <div id="header">
      <div id="htext">
        Страница <strong>{{name}}</strong>
        <div id="login">{{{login}}}</div>
      </div>
    </div>
    <div id="left">
      <div id="view" class="content">{{{markdown}}}</div>
    </div>
    <div id="editor">{{{content}}}</div>
    <script src="{{{contentRoot}}}/markdown/showdown.js" type="text/javascript"></script>
    <script src="{{{contentRoot}}}/ace/ace.js" type="text/javascript" charset="utf-8"></script>
    <script src="{{{contentRoot}}}/channel/bcsocket.js"></script>
    <script src="{{{contentRoot}}}/share/share.uncompressed.js"></script>
    <script src="{{{contentRoot}}}/share/ace.js"></script>
    <script>
window.onload = function() {
  var converter = new Showdown.converter();
  var view = document.getElementById('view');

      var editor = ace.edit("editor");
  editor.setReadOnly(true);
  editor.session.setUseWrapMode(true);
  editor.setShowPrintMargin(false);

  // This could instead be written simply as:
  // sharejs.open('{{{docName}}}', function(doc, error) {
  //   ...

  var connection = new sharejs.Connection('{{{contentRoot}}}/channel');

  connection.open('{{{docName}}}', function(error, doc) {
    if (error) {
      console.error(error);
      return;
    }
    doc.attach_ace(editor);
    editor.setReadOnly(false);

    var render = function() {
      view.innerHTML = converter.makeHtml(doc.snapshot);
    };

    window.doc = doc;

    render();
    doc.on('change', render);
  });
};
    </script>
  </body>
</html>

