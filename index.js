#!/usr/bin/env node

require('coffee-script');
var express = require('express');
var connect = require('connect');
var sharejs = require('share');
var options = require('./options');

var server = express();
server.use(express.static(__dirname + '/static'));

// Attach the sharejs REST and Socket.io interfaces to the server
sharejs.server.attach(server, options);

server.listen(3000, function(){
    console.log('Server running at port 3000');
});

var wiki = require('./client');

server.get('/?', function(req, res, next) {
  res.writeHead(301, {location: '/Main'});
  res.end();
});

server.get('/:docName', function(req, res, next) {
  var docName;
  docName = req.params.docName;
  wiki(docName, server.model, res, next);
});
