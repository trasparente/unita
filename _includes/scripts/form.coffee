#
# Form RESET
# --------------------------------
$('form').on 'reset', ->
  form = $ @
  form.addClass 'reset'
  form.find(':input').blur()
  form.find('[type=submit]').text 'SUBMIT'
  # form.trigger 'change'
  # Update focus class
  if document.hasFocus() then do focus
  return # End form reset

#
# SAVE FILE
# Check debug flag
#
# Presave, check `debug` global variable
save_file = (form, file_url, file, data) ->
  if body.data('debug') == 'true' then console.log 'DEBUG: form, file_url, file, data', form, file_url, file, data
  else put_file form, file_url, file, data
  return # End save_file

# Actual PUT request
put_file = (form, file_url, file, data) -> $.ajax
  url: file_url
  method: 'PUT'
  data: JSON.stringify $.extend {
    message: "Input form"
    content: Base64.encode file
  }, data
  success: (data) ->
    spy "File saved #{ data.content.path } Sha #{ data.commit.sha.slice 0, 7 }", 'success'
    form.trigger 'reset'
    html.removeClass('updated').addClass 'behind'
    # Wait a little for commit propagation
    if environment isnt 'development' then setTimeout get_builds, 1000
    return # End put_file