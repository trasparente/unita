# Show a message in the bottom left corner
# default class is .spy-info
# kind optional: success, warning, error
# if a form is passed [data-input="message"] is used
@spy = (msg, kind = '', form = 0) ->
  # Create widget
  timer = $('<time/>', {
    text: "#{msg} "
    datetime: new Date().toString()
    class: "spy #{if kind.length > 0 then 'spy-'+kind else ''}"
  })
  # Select container and append
  base = if !form then $('#bottom-left') else form.find '[data-input="message"]'
  base.prepend timer.prepend $('<span/>', {text: 'now'})
  # Activate in 1 second to skip singularity
  setTimeout relative_time, 1000, timer
  # Click event to remove widget
  timer.on 'click', (e) ->
    e.stopPropagation()
    target = $ e.target
    if target.prop('tagName') is 'TIME' then target.remove() else target.parent().remove()
    return
  return