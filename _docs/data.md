---
order: 3
table:
  file_extension:
    type: hidden
    value: csv
  file_name:
    type: hidden
    slug: name
    disabled: true
  file_path:
    type: hidden
    slug: folder
  name:
    type: text
    required: true
    autocomplete: 'off'
  path:
    type: text
    autocomplete: false
---
# Data
{% include widgets/toc.html %}

## Todo

1. Form with arrayzed fields group_by: panel
2. Form for forms
3. Form for tables (show table if present)
4. Generators

**Others**

- import or update data file ask `ower/repository` and check 404
- json form file already present, live values (edit function)
- delete wrong csv lines

## TABLES

{% include widgets/input.html form=page.table %}
{% include widgets/api.html include='widgets/input' %}

- `fields`:
  - `type`: text, hidden, email, textarea, number, boolean, color, date, datetime, select, select multiple, radio, ref, random, roll (csv)
  - `options`: required, disabled, placeholder

Form bottom contains a message box for the future
```html
<div data-input="message" role='status'></div>
```
- Form fields (value = default value)
  - `hidden`
    - `value` string
    - `timestamp` boolean
    - `slug` field
  - `text`
    - `value` string
    - `placeholder` string
    - `timestamp` boolean
    - `required` boolean
    - `disabled` boolean
    - `slug` field
    - `autocomplete` Quoted (on/off are yaml) string (on/off/space-separated-tokens)
  - `number`
    - `value` string
    - `min` string
    - `max` string
    - `step` string
    - `placeholder` string
    - `timestamp` boolean
    - `required` boolean
    - `disabled` boolean
    - `pool` Math expression with property names that are valid numbers es. `2*items+fee`{:.language-sass}
  - `range` <https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/input/range>
    - `value` string
    - `min` string default 0
    - `max` string default 100
    - `step` string default 1
    - `disabled` boolean
  - `roll`
    - `dice` dice format, `<num>`d`<sides>`&plusmn;`<mod>` es. `3d6+2`
    - `csv` table path in _data/ es. `gfl/race.csv`
  - `email`
    - `value` string
    - `placeholder` string
    - `autocomplete` string (on/off/space-separated-tokens)
    - `required` boolean
    - `disabled` boolean
  - `select`
    - `value` string
    - `multiple` boolean
    - `required` boolean
    - `disabled` boolean
  - `radio` (like select but can include descriptions)
  - `checkbox` (like select multiple but can include descriptions)
  - `textarea`
    - `placeholder` string
    - `required` boolean
    - `disabled` boolean
  - `color`
    - `value` string
    - `required` boolean
    - `disabled` boolean
  - `date`
    - `value` date as `YYYY-MM-DD`{:.language-q}
    - `min` date as `YYYY-MM-DD`{:.language-pony}
    - `max` date as `YYYY-MM-DD`{:.language-make}
    - `step` days of step, default 1
    - `disabled` boolean
  - `datetime`
    - `value`
    - `min` date as `YYYY-MM-DDTHH:mm`{:.language-mojo}
    - `max` date as `YYYY-MM-DDTHH:mm`{:.language-c}
    - `step` seconds of step, default 60 (1 min)
    - `disabled` boolean
- Custom fields
  - `object`
    - subfields with type ecc. (recursive)

## Exposed `api`

<fieldset>
  <legend>_DATA</legend>
  <button onclick="dataLog()">dataLog()</button>
</fieldset>
```coffeescript
# From remote:
# https://{owner}/github.com/{repository}/assets/data.json
$.getJSON('/assets/data.json').done (data) -> console.log data
```