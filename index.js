exports.handler = async (event) => {
  const response = {
    statusCode: 200,
    body: JSON.stringify({
      message: event.queryStringParameters
    });
  };

  return response;
};
