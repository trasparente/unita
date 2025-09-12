# NAVIGATION
# ----------------
sub_nav = $ '.sub-nav'
sub_nav_divs = $ ".sub-nav [data-collection]"
sub_nav_active = sub_nav_divs.has '[aria-current="page"]'
collection_links = $ '.main-nav .collection-link'
page_links = $ '.main-nav .page-link'
document_links = $ '.sub-nav .document-link'
# Reset to default .sub-nav
$('.nav-container').on 'mouseleave', (e) -> do reset_subnav
# Leave blank space for .page-link
page_links.on 'mouseenter', (e) -> reset_subnav true
page_links.on 'mouseleave', (e) -> reset_subnav
# Toggle Sub Nav on .collection-link hover
collection_links.on 'mouseenter', (e) ->
  label = $(e.target).attr 'data-label'
  sub_nav_divs.hide()
  sub_nav_divs.filter("[data-collection='#{ label }']").show()
  return
# Function to show only active sub-nav, or opacize it if .page-link
reset_subnav = (all = false)->
  sub_nav_divs.hide()
  if not all then sub_nav_active.show()
  # if opacity in [0,1] then sub_nav_active.css 'opacity', opacity
  return

# Remove all .collection-link redirects
if '404' == body.attr 'data-page-title'
  collection_links.each -> localStorage.removeItem $(@).attr 'href'

# Remember last document
if body.hasClass 'remember-document'
  col_url = collection_links.filter('[aria-current="true"]').attr 'href'
  doc_url = document_links.filter('[aria-current="page"]').attr 'href'
  # Proceed only for Collection > Document
  if col_url and doc_url

    # Save or Delete
    if col_url == doc_url
      localStorage.removeItem col_url
    else
      localStorage.setItem col_url, doc_url

  # LOOP .collection-links
  # hardcoded in navigation.html (first_doc_sorted)
  collection_links.each ->
    el = $ @
    document_url = el.attr 'href'
    # Current collection
    # if 'true' is el.attr('aria-current')
    #   console.log el
    # Check in localStorage an updated .document-link
    if localStorage.getItem document_url
      document_url = localStorage.getItem document_url
      el.attr 'href', document_url
    # Hardcoded url is to highlight
    $(".document-link[href='#{ document_url }']").addClass 'aria-current'
    return # End Collection-link loop
  # End col_url and doc_url
# End .remember-document