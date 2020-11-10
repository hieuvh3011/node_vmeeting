const baseResponseForm = (code = 0, message = "No message available", pureResponse) => {
  return {
    code: code,
    message: message,
    data: pureResponse
  }
}

module.exports = {baseResponseForm}
