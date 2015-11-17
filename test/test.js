var should = require('should');
var users = require('../lib/users.js');

describe('User tests', function() {
  it('should save user', function(done) {
    
      var testUser = { id: "1111", name: "Sterling" };

      users.save(user.name, function (testUser) {

      user.should.have.property("name", "Sterling");
      user.should.have.property("id", "2222");

      done();
    });
  });
