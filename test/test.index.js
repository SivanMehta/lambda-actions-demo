const { handler } = require('../');
const assume = require('assume');

describe('handler', function() {
  it('exists', function () {
    assume(handler).is.a('asyncfunction')
  });

  it('returns an object', async function () {
    const response = await handler();
    assume(response).is.a('object');
  });

  it('returns a status code of 200', async function () {
    const response = await handler();
    assume(response.statusCode).equals(200);
  });

  it('has a string for the body', async function () {
    const response = await handler();
    assume(response.body).is.a('string');
  });

  it('has a problem and a solution', async function () {
    const response = await handler();
    const { problem, solution } = JSON.parse(response.body);
    assume(problem).is.a('string');
    assume(solution).is.a('string');
  })
})
