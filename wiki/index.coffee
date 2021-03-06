# This statically renders the wiki.

fs = require 'fs'
Mustache = try
  require 'mustache'
catch e
  {to_html: -> "<body><pre>% npm install mustache</pre> to use this demo."}

showdown = new (require('../static/markdown/showdown').converter)()

template = fs.readFileSync "#{__dirname}/wiki.html.mu", 'utf8'
auth = require '../auth'

defaultContent = (name) ->
  """
  # #{name} page

  DICHOTOMY OF AN ENTRY (Improve!)

  Title

  Short description

  Subsections (if many consider sub-subjects)


  See also


  This wiki page is currently empty.

  You can put some content in it with the editor on the right. As you do so, the document will update live on the left, and live for everyone else editing at the same time as you. Isn't that cool?

  The text on the left is being rendered with markdown, so you can do all the usual markdown stuff like:

  - Bullet
  - Points

  [links](http://google.com)

  [Go back to the main page](Main)
  """

render = (content, name, docName, req, res) ->
  markdown = showdown.makeHtml content
  site = 'http://cmpip.org'
  contentRoot = '/wiki'
  user = auth(req.headers)
  if user
    login = "Пользователь: #{user}"
  else
    self = encodeURIComponent(site + contentRoot + req.path)
    login = "<a href='/wordpress/wp-login.php?redirect_to=#{self}'>Вход на сайт</a>"

  html = Mustache.to_html template, {content, markdown, name, docName, contentRoot, login}
  res.writeHead 200, {'content-type': 'text/html; charset=utf-8'}
  res.end html

module.exports = (docName, model, req, res) ->
  name = docName
  docName = "wiki:" + docName

  model.getSnapshot docName, (error, data) ->
    if error is 'Document does not exist'
      model.create docName, 'text', ->
        content = defaultContent(name)
        model.applyOp docName, {op: [{i: content, p: 0}], v: 0}, ->
          render content, name, docName, req, res
    else
      render data.snapshot, name, docName, req, res
