exports.handler = async (event) => {
  const response = {
    statusCode: 200,
    body: JSON.stringify('Hello from AWS S3!')
  };

  return response;
};
