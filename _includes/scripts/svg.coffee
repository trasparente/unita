# SVG PREVIEW INTERACTION
$('svg').each ->
  svg = $ @
  svg.find('[data-text]').each (i, el) ->
    cont = $ "##{$(el).attr 'data-text'}"
    if cont.length
      cont.eq(0).on 'keyup', (e) -> $(el).text $(e.target).val()
      cont.eq(0).trigger 'keyup'
    return
  svg.find('[data-fill]').each (i, el) ->
    cont = $ "##{$(el).attr 'data-fill'}"
    if cont.length
      cont.eq(0).on 'change reset', (e) -> $(el).css 'fill', $(e.target).val()
      cont.eq(0).trigger 'change'
    return
  return