logout = (token) ->
  html.addClass('unlogged').removeClass 'logged admin guest'
  # $('[href="#logout"]').attr 'title', 'Click to logout'
  localStorage.removeItem 'user'
  localStorage.removeItem 'role'
  localStorage.removeItem 'branch'
  localStorage.removeItem 'parent'
  if token
    localStorage.clear()
    alert 'Logged out'
  return

$('a[href="#login"]').on 'click', ->
  token = prompt "Paste a GitHub personal token"
  if token
    localStorage.removeItem 'token'
    bootstrap token
  return

$('a[href="#logout"]').on 'click', ->
  if confirm "#{ $(@).attr 'data-info' }\nLOGOUT?" then logout localStorage.getItem 'token'
  return

#
# AUTH FUNCTIONS
# --------------
# GitHub auth, personal token as argument
get_auth = (token) -> $.get
  url: '{{ site.github.api_url }}/user'
  headers: { 'Authorization': "token #{ token }" }
  success: (user) ->
    html.removeClass('unlogged').addClass 'logged'
    localStorage.setItem 'token', if environment is 'development' then token else Base64.encode token
    localStorage.setItem 'user', user.login
    return # End get_auth done
  error: (request) -> # Reset token if Requires authentication or Forbidden
    if [401, 403].includes request.status then logout token else do logout
    return # End get_auth error