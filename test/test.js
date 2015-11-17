var should = require('should');
describe('User tests', function() {
  it('should save user', function(done) {
    var user = new User('22');
    user.save(done);

    });
  });
