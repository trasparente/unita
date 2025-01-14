# YAML to JSON: jsyaml.load YAML-string
# JSON to YAML: jsyaml.dump JSON-object

# VAR
# --------------------------------------
win = $(window)
dom = $(document)
html = $ 'html'
body = $ 'body'
today = +new Date().setHours 0,0,0,0
environment = '{{ site.github.environment }}'
github_repo_url = '{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}'
lang = html.attr 'lang'

#
# HELPER FUNCTIONS
# ----------------
# Prevent-default class
dom.on 'click', 'a.prevent', (e) -> e.preventDefault()
dom.on 'submit', 'form.prevent', (e) -> e.preventDefault()
# Return ISO 8601 date YYYY-MM-DD
date_iso = (date) -> new Date(date || +new Date()).toLocaleDateString 'sv'
# Get data file url from data-file form attribute
# If it is a fork, save inside 'user' folder
url_from_data_file = (form) -> "#{ github_repo_url }/contents/_data/#{ form.data 'file' }"

#
# MARKUP HELPERS
# --------------
# Duplicate `[href]` in empty `[title]`
$('a[href]:not([title])').each -> $(@).attr 'title', $(@).attr 'href'
# Citations
$('[cite]:not([title])').each -> $(@).attr 'title', $(@).attr 'cite'

#
# DOM EVENTS
# ----------
#
# SCROLL Event
# Add `html.scrolled` when scroll > win height (1 page)
win.scroll () -> if win.scrollTop() > win.height() / 5 then html.addClass 'scrolled' else html.removeClass 'scrolled'

# FOCUS / BLUR
# Called from BODY events
@focus = -> html.addClass('focus').removeClass 'blur'
@blur = -> html.addClass('blur').removeClass 'focus'
if document.hasFocus() then do focus else do blur

# RESIZE EVENT
# Add class `fullscreen` and `mobile` if the case
# Called from BODY attribute
@resize = ->
  # Fullscreen
  if window.innerHeight is screen.height then html.addClass 'fullscreen'
  else html.removeClass 'fullscreen'
  # Mobile screen
  if window.innerWidth <= 650 then html.addClass('mobile').removeClass 'big-screen'
  else html.removeClass('mobile').addClass 'big-screen'
  return
do resize

# Hash, fragment identifier change
# Called from BODY attribute
@onhashchange = -> console.log window.location.hash

# ONLINE / OFFLINE
# Called from BODY attribute
@online = -> html.addClass('online').removeClass 'offline'
@offline = -> html.addClass('offline').removeClass 'online'
# Initial call
if navigator.onLine then do online else do offline

#
# AUTH FUNCTIONS
# --------------
# GitHub auth, personal token as argument
get_auth = (token) -> $.get
  url: '{{ site.github.api_url }}/user'
  headers: { 'Authorization': "token #{ token }" }
  success: (user) ->
    html.removeClass('unlogged').addClass 'logged'
    localStorage.setItem 'token', token
    localStorage.setItem 'user', user.login
    return # End get_auth done
  error: (request) -> # Reset token if Requires authentication or Forbidden
    if [401, 403].includes request.status then logout token else do logout
    return # End get_auth error

get_repo = (user, token) -> $.get
  url: github_repo_url
  success: (repo) ->
    localStorage.setItem 'branch', repo.default_branch
    localStorage.setItem 'parent', repo.parent?.full_name || ''
    # Store role
    role = if repo.permissions.admin then 'admin' else 'guest'
    html.addClass role
    localStorage.setItem 'role', role
    # Alert for login
    message = "#{ user.login } logged as #{ role }"
    $('[href="#logout"]').attr 'title', message
    if token then spy message
    return # End get_repo done

# Get pages builds and check the last one
get_builds = -> $.get
  url: github_repo_url + '/pages/builds'
  success: (builds) ->
    status = $ '[role="marquee"] .behind'
    if builds[0].status is 'built' or environment is 'development'
      # -------
      # UPDATED
      # -------
      if html.hasClass 'behind'
        # Was behind
        updated_url = [
          window.location.origin
          window.location.pathname
          '?update_to='
          builds[0].updated_at
        ].join ''
        history.pushState null, '', updated_url
        # Activate button
        status.addClass 'blink pointer'
        status.on 'click', () -> window.location.href = updated_url
      else
        html.removeClass 'behind'
          .addClass 'updated'
    else
      # ------
      # BEHIND
      # ------
      html.removeClass 'updated'
        .addClass 'behind'
      # Check again in 60 thousands of milliseconds
      setTimeout get_builds, 1000*60
    return # End get_builds done

# Get Forks recursively
get_forks = (pg = 1, forks = []) -> $.get
  url: github_repo_url + '/forks'
  per_page: 100
  page: pg
  success: (data, status, request) ->
    output = forks.concat data
    links = request.getResponseHeader 'links'
    if links && links.includes 'rel="next"'
      get_forks pg+1, output
    else console.log "#{fork.name} #{fork.updated_at} #{fork.id}" for fork in output 
    return # End get_forks

# Get parent repo last commit
get_parent_commits = (builds, repo) -> $.get
  url: "{{ site.github.api_url }}/repos/#{ repo.parent?.full_name }/commits"
  success: (commits) ->
    # Compare parent last commit time with this forked site last build time
    commit_after_build = +new Date(commits[0].commit.author.date) / 1000 > {{ site.time | date: "%s" }}
    if commit_after_build then sync_upstream().done -> do get_builds
    return # End get_parent_commits done

# Sync with upstream
# https://docs.github.com/en/rest/branches/branches#sync-a-fork-branch-with-the-upstream-repository
sync_upstream = -> $.ajax
  url: github_repo_url + '/merge-upstream'
  method: 'POST'
  data: JSON.stringify { "branch": localStorage.getItem 'branch' }
  success: (response) -> spy response.message

#
# CSV FUNCTIONS
# --------------
# Check existence of csv and save new data
get_csv_file = (form, file_url, file, header, row) -> $.get
  url: file_url
  # arguments: Object, 'error', 'Not Found'
  error: (request, textStatus , errorThrown) -> if request.status is 404 then save_file form, file_url, file
  success: (data) ->
    # Decode old file and split
    # Boolean remove empty elements
    csv_array = Base64.decode data.content
      .split '\n'
      .filter Boolean
    # Update old head
    csv_array[0] = header
    # append row
    csv_array.push row
    new_file = csv_array.join '\n'
    save_file form, file_url, new_file, {sha: data.sha}
    return # End get_csv_file done

get_json_file = (form, file_url, file) -> $.get
  url: file_url
  # arguments: Object, 'error', 'Not Found'
  error: (request, textStatus , errorThrown) -> if request.status is 404 then save_file form, file_url, file
  success: (data) -> save_file form, file_url, file, {sha: data.sha}

save_file = (form, file_url, file, data) -> $.ajax
  url: file_url
  method: 'PUT'
  data: JSON.stringify $.extend {
    message: "Commit data content #{ form.data 'file' }"
    content: Base64.encode file
  }, data
  success: (data) ->
    spy "Committed #{ data.content.path } as #{ data.commit.sha.slice 0, 7 }", 'success', form
    form.trigger 'reset'
    html.removeClass('updated').addClass 'behind'
    if environment isnt 'development' then do get_builds
    return # End save_file

#
# BOOTSTRAP
# --------------
# Called onload body attribute with no argument
# Called on login with token as argument
@bootstrap = (token) ->
  # retrieve token
  t = token || localStorage.getItem 'token'
  if t
    get_auth(t).done (user) ->
      # use Bootstrap token for first login
      get_repo(user, token).done (repo) ->
        # If admin check builds
        if repo.permissions.admin then get_builds().done (builds) ->
          if repo.fork and builds[0].status is 'built'
            get_parent_commits builds, repo
          else do get_forks
  else do logout
  return # End bootstrap