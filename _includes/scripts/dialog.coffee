dialog = $ '<dialog/>',{open: ''}
close = $ 'button', {autofocus: '', text: '✖'}
paragraphs = [
  # First paragraph
  $('p', {text: 'hello'})
]
div = $('<div/>').append(close).append paragraphs
console.log dialog.append div