# Get data file url from data-file form attribute
# If it is a fork, save inside 'user' folder
url_from_data_file = (form) -> "#{ github_repo_url }/contents/_data/#{ form.data 'file' }"

#
# Forms SUBMIT
# --------------------------------
# [data-file$=".json"]
# [data-file$=".csv"]

# CSV
$('form.old[data-file$=".csv"]').on 'submit', ->
  form = $ @
  form.find(':input').blur()
  file_url = url_from_data_file form
  # Array of objects {name: '...', value: '...'}
  serialized = form.serializeArray()
  header = serialized.map((i) -> JSON.stringify i.name).join ','
  row = serialized.map((i) -> JSON.stringify i.value).join ','
  file = [header, row].join '\n'
  get_csv_file form, file_url, file, header, row
  return # End form submit

# JSON
$('form.old[data-file$=".json"]').on 'submit', ->
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