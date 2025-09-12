#
# DOM EVENTS
# ----------

# Mouse position
[mouseX, mouseY] = [0, 0]
doc.mousemove (e) -> [mouseX, mouseY] = [e.pageX, e.pageY]

# SCROLL Event
# Add `html.scrolled` when scroll > win height (1 page)
win.scroll () ->
  if ($('.nav-container').offset().top) - (doc.scrollTop()) is 0
    html.addClass 'nav-stick'
  else html.removeClass 'nav-stick'
  if win.scrollTop() > win.height() / 5
    html.addClass 'scrolled'
  else html.removeClass 'scrolled'
  return

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
  if window.innerHeight is screen.height and window.innerWidth is screen.width and window.innerWidth > 650
    html.addClass('fullscreen not-big-screen not-mobile').removeClass 'not-fullscreen big-screen mobile'
  else
    html.addClass('not-fullscreen').removeClass 'fullscreen'
    # Mobile screen
    if window.innerWidth <= 650
      html.addClass('mobile not-big-screen').removeClass 'big-screen not-mobile'
    else html.addClass('big-screen not-mobile').removeClass 'mobile not-big-screen'

  # Check document SHOTER than window
  if window.innerHeight > document.body.scrollHeight
    html.addClass 'shorter'
  else html.removeClass 'shorter'
  return # End resize

# First run
do resize

# Hash, fragment identifier change
# Called from BODY attribute
@onhashchange = -> console.log 'onhashchange', window.location.hash

# ONLINE / OFFLINE
# Called from BODY attribute
@online = -> html.addClass('online').removeClass 'offline'
@offline = -> html.addClass('offline').removeClass 'online'
# Initial call
if navigator.onLine then do online else do offline

# Start-stop keyboard for html.crono
# return-13 space-32 0-48 1-49 2-50 3-51 4-52 5-53 6-54 7-55 8-56 9-57
win.keypress (e) -> if body.hasClass('crono')
  console.log 'key', e.which
  if e.which == 32
    spy 'Time check'