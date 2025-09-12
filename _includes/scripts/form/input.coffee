file_url_string = (form) ->
  # Return as [file_path /]file_name.file_extension
  return [
    form.find('#file_path').val()
    form.find('#file_name').val()
  ].filter(Boolean).join('/') + '.' + form.find('#file_extension').val()

check_merge = (form) -> form.find('#file_merge').val() || false

#
# INPUT
# <form class="input" data-form="{ json object }"> ... </form>
# --------------------------------

$('form.input[data-form]').each ->
  form = $ @
  file_data = null

  form.on 'reset', ->
    form.find('[data-input="message"]').empty().append "_data/"
    return

  # EVENT ON CHANGE of file URL
  # Check existence
  form.on 'change reset', '[id^="file_"]', (el, ev) ->
    file_url = file_url_string form
    if file_url
      form.find('[data-input="message"]').empty().append "_data/<span class='filename'>#{ file_url }</span>"
      # Return file if present
      $.get
        url: file_url
        # Request error
        error: (request, textStatus , errorThrown) ->
          form.addClass('not-found').removeClass 'found'
          form.find('[type=submit]').val('CREATE')
          return
        # Return data
        success: (data) ->
          form.removeClass('not-found').addClass 'found'
          form.find('[type=submit]').val('UPDATE')
          file_data = data
          return
    # return_file_data(url).done (data) ->
    #   console.log data
    return

  # Loop data-slug fields
  # Add slug event to target element
  form.find('[data-slug]').each ->
    field = $ @
    slug = form.find "#" + field.data 'slug'
    slug.on 'change', ->
      field.val slugify slug.val()
      field.trigger 'change'
      return # End slugify event
    slug.on 'reset', ->
      field.val ''

    return # End [data-slug]

  # Prevent submit on Enter key, move focus on submit
  form.on 'keypress', (key) ->

    # Reset .reset class
    form.removeClass 'reset'

    # Change Enter key on fields into submit focus
    # Except on submit
    type = $(key.target).attr 'type'
    if type isnt 'submit' and type isnt 'reset' and ( 0 || key.keyCode || key.charCode ) is 13
      key.preventDefault()
      form.find('[type=submit]').focus()

    return # End form.keypress

  # SUBMIT
  form.on 'submit', ->
    form.addClass 'submit'
    # data_form = form.data 'form'
    file_url = "#{ github_repo_url }/contents/_data/#{ file_url_string form }"
    form.find(':input').blur()
    file = switch form.find('#file_extension').val().toLowerCase()
      # Json format
      when 'json' then form_to_object form
      # Yaml format
      when 'yaml', 'yml' then jsyaml.dump form_to_object form
      # Csv format
      when 'csv' then form_to_array form
    # CREATE / WRITE: file, file_url
    console.log file_url, file
    # create_save file, file_url

    return # End form submit

  # JSON file

  return # End Input loop

#
# HELPERS
#

#
# FORM to File
#
form_to_object = (form) ->
  file = {}

  # Loop normal fields
  form.find('input:not([type=radio],[type=submit],[type=reset],[type=button],[type=hidden]')
    .each ->
      el = $ @
      # tag = el.prop 'tagName'
      file[el.attr 'name'] = switch el.attr 'type'
        # Number type
        when 'number' then Number el.val()
        # String: All others
        else el.val()
      return # End fields loop

  # Loop radio fields
  form.find('input[type=radio]:checked').each ->
    el = $ @
    name = el.attr 'name'
    file[name] = el.val()
    return # End radio loop

  return file

form_to_array = (form, data) ->
  # heades = headers array
  # row = new or modified
  file = []
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
  # save_file form, file_url, new_file, {sha: data.sha}

  return new_file