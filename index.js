exports.handler = async (event) => {
  const response = {
    statusCode: 200,
    body: JSON.stringify({
      message: 'Hi there!',
      query: event.queryStringParameters
    })
  };

  return response;
};
