User = {}

User.get = (req, res, next) ->
  return res.send req.user if req.user
  return res.send 401

module.exports = User
