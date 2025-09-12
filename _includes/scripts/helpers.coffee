# YAML to JSON: jsyaml.load YAML-string
# JSON to YAML: jsyaml.dump JSON-object

# VAR
# --------------------------------------
win = $ window
doc = $ document
html = $ 'html'
body = $ 'body'

# GENERAL
today = +new Date().setHours 0,0,0,0
environment = '{{ site.github.environment }}'
github_repo_url = '{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}'
lang = html.attr 'lang'

# .prevent Class .preventDefault()
doc.on 'click', 'a.prevent', (e) -> e.preventDefault()
doc.on 'submit', 'form.prevent', (e) -> e.preventDefault()

# MARKUP HELPERS
# --------------
# Duplicate `[href]` in empty `[title]`
$('a[href]:not([title]), a[href][title=""]').each -> $(@).attr 'title', $(@).attr 'href'
# Citations
$('[cite]:not([title]), [cite][title=""]').each -> $(@).attr 'title', $(@).attr 'cite'
# Form required input
$('input[required]:not([placeholder])').each -> $(@).attr 'placeholder', 'required'
# Headings anchor links
$('body.headings-anchor main').on 'click', 'h1[id], h2[id], h3[id]', (e) -> window.location.href = [
    window.location.origin
    window.location.pathname
    '#'
    e.currentTarget.id
  ].join ''

#
# HELPER FUNCTIONS
# ----------------

@dataLog = ->
  return $.getJSON '/assets/data.json'
    .done (data) -> console.log data

# Slug strings
@slugify = (string) -> 
  return string.toString().toLowerCase().trim()
    .replace /[^\w\s\.—-]/g, '' # Remove every: not word, space, dot, dashes
    .replace /[\s\.—-]+/g, '_' # Replaces space, dot, dashes with underscore
    .replace /^_+|_+$/g, '' # Trim underscore