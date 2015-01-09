#!/usr/local/bin/node
var fs = require('fs');
var config = JSON.parse(fs.readFileSync(__dirname + '/terraform.tfstate', 'utf8'));
var resources = config.modules[0].resources;

var stream = fs.createWriteStream("private/inventory");
stream.once('open', function (fd) {
  function writeHost(host) {
    stream.write(host.public_ip);
    for (var key in host) {
      stream.write(" " + key + "=" + host[key]);
    }
    stream.write("\n");
  }

  for (var key in resources) {
    var resource = resources[key];
    if (resource.type == 'aws_instance') {
      var host = {
        public_ip: resource.primary.attributes.public_ip,
        private_ip: resource.primary.attributes.private_ip
      };
      var myRegexp = /aws_instance\.([^.]*)/g;
      var match = myRegexp.exec(key);
      if (match) {
        host.type = match[1];
      }
      writeHost(host);
    }
  }

  stream.end();
});
