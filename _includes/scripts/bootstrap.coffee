#
# BOOTSTRAP
# --------------
# Called onload body attribute with no argument
# Called on login with token as argument
@bootstrap = (token) ->
  console.log 'Bootstrap', if token then 'token' else 'no token'
  # retrieve token
  t = token || if environment is 'development' then localStorage.getItem 'token' else Base64.decode localStorage.getItem 'token'
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
  # Move to tables manipulation
  do table_ui
  # spy 'Default'
  # spy 'Info', 'info'
  # spy 'Success', 'success'
  # spy 'Warning', 'warning'
  # spy 'Error', 'error'
  return # End bootstrap

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
    message = "#{ user.login } LOGGED AS #{ role }"
    $('[href="#logout"]').attr 'data-info', message
    if token then spy message
    return # End get_repo done

# Get pages builds and check the last one
get_builds = -> $.get
  url: github_repo_url + '/pages/builds'
  success: (builds) ->
    status = $ '#status .behind'
    if builds[0].status is 'built' or environment is 'development'
      # UPDATED from BEHIND
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
      # UPDATED
      else html.addClass 'updated'
    else
      # BEHIND
      html.removeClass 'updated'
        .addClass 'behind'
      # Check again in 30 secs
      setTimeout get_builds, 1000 * {{ site.check | default: 30 }}
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