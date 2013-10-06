cookie = require 'cookie'

module.exports = (headers) ->
  header = headers["cookie"]
  return null if !header

  cookies = cookie.parse(header)
  return null if !cookies

  wp_cookie = cookies['wordpress_ae900921635efaeb4fb81dcc09a4fdf4']
  return null if !wp_cookie

  wp_cookie.split('|')[0]
