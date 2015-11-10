//import a module
var http= require('http');

var users= require('./src/users.js');

//declare a http server
http.createServer(function (req, res) {

var path = req.url.split("/")
//localhost:1337/a/b
// /get/:id
// /save/name


if (path[0] == "get") {
users.get(path[1], function (user) {

var response = {
	info: "here your user",
	user : user
	}
	res.writeHead(200, {content: 'application/json'});
	res.end(JSON.stringify(response));
	})
	
} else if (path[0] == "save") {
users.save(path[1], function (user) {
var response = {
	info: "user saved",
	user: user
	}
	res.writeHead(200, {content: 'application/json'});
	res.end(JSON.stringify(response));
	})
	
}else {
	res.writeHead(404, {content: 'text/plain'});
	res.end("not a good path");
 	}


//write a response header
//res.writeHead(200, {content: 'application/json'});



}).listen(1337, '127.0.0.1');