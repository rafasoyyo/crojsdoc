{collect} = require '../..'
{expect} = require 'chai'

describe 'multiline', ->
  it '@param', ->
    result = collect [
      { path: 'test.coffee', file: 'test.coffee', data: """
##
# @module test

##
# Do something
# @param {String} p This is a long description
# on multilines.
# This is the third line.
#
# And blank line.
# @memberOf test
doSomething = (p) -> p
""" }
    ]
    expect(result.modules).to.have.length 1
    expect(result.modules[0].properties).to.have.length 1
    params = result.modules[0].properties[0].params
    expect(params).to.have.length 1
    expect(params[0]).to.be.eql
      type: 'param'
      types: ['String']
      name: 'p'
      description: 'This is a long description\non multilines.\nThis is the third line.\n\nAnd blank line.'

  it '@return', ->
    result = collect [
      { path: 'test.coffee', file: 'test.coffee', data: """
##
# @module test

##
# Do something
# @return {String} This is a long description
# on multilines.
# This is the third line.
#
# And blank line.
# @memberOf test
doSomething = -> 'something'
""" }
    ]
    expect(result.modules).to.have.length 1
    expect(result.modules[0].properties).to.have.length 1
    ret = result.modules[0].properties[0].return
    expect(ret).to.be.eql
      type: 'return'
      types: ['String']
      description: 'This is a long description\non multilines.\nThis is the third line.\n\nAnd blank line.'
