# Body Click Handler
# remove Overlay and close .tips
win.click () ->
  if body.hasClass 'overlay'
    $('.tip').remove()
    $('tr').removeAttr 'aria-selected'
    body.removeClass 'overlay'
  return

# Table.coffee
# Add event to table rows and show tip with actions
table_ui = ->
  # Body rows
  $('table[data-limit][data-sort] tbody td').each ->
    cell = $ @
    cell.on 'click', (e) ->
      # Do not disturb body
      e.stopPropagation()
      # Reset situation
      $('.tip').remove()
      $('tr').removeAttr 'aria-selected'
      # Prepare elements
      row = cell.parent 'tr'
      div1 = $ '<button/>', {text: "Edit cell #{cell.attr 'data-header'}"}
      div2 = $ '<button/>', {text: "Delete row #{row.attr 'data-row'}"}
      tip = $ '<div/>', {class: 'tip'}
      row.attr 'aria-selected', 'true'
      # Append and position
      body.append tip.append div1, div2
      setTimeout (() -> body.addClass('overlay')), 400
      right = if mouseX > win.width() / 2 then true else false
      top = if mouseY-win.scrollTop() < win.height() / 2 then true else false
      dx = if right then '-100%' else '0'
      dy = if top then '0' else '-4em'
      tip.css
        'top': mouseY
        'left': mouseX
        'transform': "translate(#{dx}, #{dy})"
      # Click event
      tip.on 'click', (e) ->
        tip.remove()
        row.removeAttr 'aria-selected'
        body.removeClass 'overlay'
        return # End .tip click
      return # End cell click
    return # End td loop
  return # End table_ui function