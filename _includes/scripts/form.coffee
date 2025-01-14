#
# Forms SUBMIT
# --------------------------------

# CSV
$('form[data-file$=".csv"]').on 'submit', ->
  form = $ @
  form.find(':input').blur()
  file_url = url_from_data_file form
  # Array of objects {name: '...', value: '...'}
  serialized = form.serializeArray()
  header = serialized.map((i) -> i.name).join ','
  row = serialized.map((i) -> i.value).join ','
  file = [header, row].join '\n'
  get_csv_file form, file_url, file, header, row
  return # End form submit

# JSON
$('form[data-file$=".json"]').on 'submit', ->
  form = $ @
  form.find(':input').blur()
  file_url = url_from_data_file form
  # Serialize form fields in `file`, except Europa
  file = {}
  form.find(':input')
    .not(':input[type=submit], :input[type=reset], :input[type=button]')
    .each ->
      el = $ @
      name = el.attr 'name'
      type = el.attr 'type'
      tag = el.prop 'tagName'
      val = el.val()
      file[name] = if type in ['number', 'boolean'] then Number val else val
      return
  get_json_file form, file_url, JSON.stringify file
  return # End form submit

#
# Form RESET
# --------------------------------
$('form').on 'reset', ->
  form = $ @
  form.find(':input').blur()
  # Update focus class
  if document.hasFocus() then do focus
  return # End form reset

# SVG PREVIEW INTERACTION
$('svg').each ->
  svg = $ @
  svg.find('[data-text]').each (i, el) ->
    cont = $('form').find "##{$(el).attr 'data-text'}"
    if cont.length
      cont.eq(0).on 'keyup', (e) -> $(el).text $(e.target).val()
      cont.eq(0).trigger 'keyup'
    return
  svg.find('[data-fill]').each (i, el) ->
    cont = $('form').find "##{$(el).attr 'data-fill'}"
    if cont.length
      cont.eq(0).on 'change reset', (e) -> $(el).css 'fill', $(e.target).val()
      cont.eq(0).trigger 'change'
    return
  return
