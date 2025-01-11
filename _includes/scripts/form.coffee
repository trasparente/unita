$('form[data-file$=".csv"]').on 'submit', ->
  form = $ @
  form.find(':input').blur()
  file_url = url_from_data_file form
  # Array of objects {name: '...', value: '...'}
  serialized = form.serializeArray()
  header = serialized.map((i) -> i.name).join ','
  row = serialized.map((i) -> i.value).join ','
  file = [header, row].join '\n'
  # get_csv_file form, file_url, file, header, row
  console.table file
  console.table header, row
  return # End form submit