should = require('should')
users = require('../lib/users.js')

describe 'User tests', ->
  it 'should save user', (done) ->
    testUser = 
      id: '1111'
      name: 'Sterling'
    users.save user.name, (testUser) ->
      user.should.have.property 'name', 'Sterling'
      user.should.have.property 'id', '2222'
      done()
      return
    return

  it 'should get user', (done) ->
    testUser = 
      id: '1111'
      name: 'Sterling'
    users.get user.id, (testUser) ->
      user.should.have.property 'name', 'cesar'
      user.should.have.property 'id', '1111'
      done()
      return
    return
  return

