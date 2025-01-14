# Display relative time with eventual update
# Add temporal classes
# Add readable date as title
seconds =
  years: 3600 * 24 * 365
  months: 3600 * 24 * 30
  weeks: 3600 * 24 * 7
  days: 3600 * 24
  hours: 3600
  minutes: 60
  seconds: 1
relative_time = (e) ->
  el = $ e
  datetime = el.attr 'datetime' || new Date()
  duration = duration_seconds(el.attr('duration') || 'P')
  formatter = new Intl.RelativeTimeFormat lang, { style: 'short' }
  date = if datetime instanceof Date then datetime else new Date datetime
  secondsElapsed = (date.getTime() - Date.now()) / 1000
  if duration
    while secondsElapsed < 0
      date.setTime(date.getTime()+duration*1000)
      secondsElapsed = (date.getTime() - Date.now()) / 1000
  for unit, value of seconds
    if value < Math.abs secondsElapsed
      delta = secondsElapsed / value
      # Check if needs updates
      if unit in ['minutes', 'seconds']
        setTimeout relative_time, seconds[unit] * 1000, e
      # Add classes
      el.removeClass 'past future today tomorrow'
      iso = date_iso date
      tomorrow = new Date()
      if iso is do date_iso then el.addClass 'today'
      if iso is date_iso tomorrow.setTime(tomorrow.getTime()+seconds.days*1000) then el.addClass 'tomorrow'
      el.addClass (secondsElapsed > 0) ? 'past' : 'future'
      # Add title
      el.attr 'title', date.toLocaleDateString(lang, {
        weekday: "short", day: "numeric", month: "short", year: "numeric"
      }) + " #{date.toLocaleTimeString(lang)} Δ#{Math.abs delta.toFixed 2}"
      # Display relative time
      el.find('span').text formatter.format Math.round(delta), unit
      break
  return secondsElapsed

# Convert ISO-8601 duration string in seconds
@duration_seconds = (string) ->
  amount = 0
  d_array = string.match(/^P(\d+Y)?(\d+M)?(\d+W)?(\d+D)?(T(\d+H)?(\d+M)?(\d+S)?)?$/) || []
  ms_array = [null, seconds.years, seconds.months, seconds.weeks, seconds.days, null, seconds.hours, seconds.minutes, seconds.seconds]
  # Loop milliseconds array
  for e, i in ms_array
    # If milliseconds and string match,
    if e and d_array[i] then amount += e * +d_array[i].slice 0, -1
  return amount

# Bootstrap
$('time[datetime]').each -> relative_time @

@spy = (msg, kind = 'info', form = 0) ->
  timer = $('<time/>', {
    text: "#{msg} "
    datetime: new Date().toString()
    class: "spy-#{kind}"
  })
  base = if !form then $('#bottom-left') else form.find '[data-input="message"]'
  base.prepend timer.append $('<span/>')
  setTimeout relative_time, 1000, timer
  timer.on 'click', (e) ->
    e.stopPropagation()
    target = $ e.target
    if target.prop('tagName') is 'TIME' then target.remove() else target.parent().remove()
    return
  return