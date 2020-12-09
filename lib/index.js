const { name, hacker } = require('faker')

exports.handler = async function handler(event) {
  const problem = `The ${name.jobTitle()} discovered that the ${hacker.adjective()} ${hacker.noun()} is broken`;
  const solution = hacker.phrase();

  const response = {
    statusCode: 200,
    body: JSON.stringify({ problem, solution })
  };

  return response;
};
