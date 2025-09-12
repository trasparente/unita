---
date: 2025-01-04
categories: Ishvara Brahman
tags: Atman
form:
  file: time.csv
  fields:
    date:
      type: datetime
      default: today midnight
    category:
      type: text
      autocomplete: category
    details:
      type: text
      autocomplete: details
    value:
      type: number
    duration:
      type: text
      autocomplete: duration

---
# Initial commit

{% include widgets/form.html %}
{% include widgets/view.html csv='time' %}