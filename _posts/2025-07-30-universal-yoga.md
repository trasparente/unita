---
date: 2025-07-30
order: 100
aside: false
---
# Universal Yoga

- add duration to total poses breaths

**<span style='color: var(--yellow);'>Namaskar</span> <span style='color: var(--ink-green);'>Asana</span> <span style='color: var(--ink-cyan);'>Pranayama</span> <span style='color: var(--cyan);'>Vinyasa</span> <span style='color: var(--green);'>Mudra</span> <span style='color: var(--yellow);'>Interpose</span> <span style='color: var(--ink-violet);'>Dhyana</span>**

{% assign open = '1,6,9' | split: ',' %}
{% assign close = '5,8,13' | split: ',' %}
{% assign ul = '4,8,13' | split: ',' %}
{% assign breaths = 0 %}
{% assign poses = 0 %}

<div class='flex'>
{% for s in site.data.uy['sūtrita_prescription'] %}{% capture string %}{{ forloop.index }}{% endcapture %}{% if open contains string %}<div class='third' markdown='1'><div class='five'>{% endif %}{% assign head = s[0] | split: '.' %}<div class='section' data-number='{{ head[0] }}'>{% if head[0] != '0' %}{{ head[0] }}. {% else %}&nbsp;&nbsp;&nbsp;{% endif %}<span class='name'>{{ head[1] | upcase }}</span> <span class='trad'>{{ head[2] | replace: '_', ' ' }}</span>
<ul>{% assign br = 0 %}{% assign po = 0 %}
  {% for p in s[1] %}<li data-type='{{ p[0] }}'><div class='type'>{{ p[0] }}</div> <div class='poses'>{{ p[1] }}</div> <div class='rep'>{{ p[2] }}</div> <div class='count'>{{ p[4] }}</div> <span><div class='name'>{{ p[3] }}</div> <div class='trad'>{{ p[5] }}</div></span></li>
  {% assign x = p[2] | replace: 'x', '' | plus: 0 %}{% if x == 0 %}{% assign x = 1 %}{% endif %}
  {% assign posa = p[1] | replace: '(', '' | replace: ')', '' | plus: 0 %}
  {% assign po = po | plus: posa %}
  {% assign tot = posa | times: x %}
  {% assign br = br | plus: tot %}
  {% endfor %}*{{po}}-{{br}}*
  {% assign breaths = breaths | plus: br %}
  {% assign poses = poses | plus: posa %}
</ul></div>
<!-- Close fifth and third -->
{% if close contains string %}</div></div>{% endif %}
{% endfor %}
<!-- Close flex -->
</div>*{{poses}}-{{breaths}}*

# Gherandasana

- spine:
  - neck: b
  - chest: d
  - waist: b
- arm.right:
  - shoulder: dub
  - elbow: s
  - wrist: b
- leg.right:
  - hip: db
  - knee: s
  - ankle: db
- leg.left:
  - hip: db
  - knee: db
  - ankle: db
- arm.left:
  - shoulder: dub
  - elbow: s
  - wrist: b

<style type="text/css">

/* Full screen */
html.fullscreen main {
  cursor: none;
}
html.fullscreen .nav-container {
  display: flex;
  justify-content: space-around;
}
html.fullscreen .nav-container > nav:nth-child(1) {
  width: 100%;
  align-items: center;
}
html.fullscreen .nav-container > nav:nth-child(1) > nav:nth-child(2) {
  padding-block: 0;
}
{% capture style %}
/* ----------------------------- SASS */
main > h1, footer
  display: none
main
  font-size: 21px
  .trad
    font-weight: normal
    font-size: smaller
    color: var(--shade-grey)
  .trad, .name
    text-transform: capitalize
  .five
    .section
      padding-block: .3em .1em
      &[data-number='0']
        background: var(--bg-subtle)
        border-radius: var(--border-radius)
      & > .name
        color: var(--ink-red)
    .name
      min-width: 12em
      font-weight: 600
      font-size: 23px
      text-transform: capitalize
    ul
      list-style-type: none
      margin-block: .2em .5em
      padding-inline-start: .6em
      li
        div
          display: inline-block
        .type, .poses, .rep, .count
          font-weight: 600
          min-width: 1.5em
          text-align: center
        .type, .poses, .count
          text-transform: capitalize
        .count
          font-size: smaller
          min-width: 5em
          color: var(--shade-light)
        .rep
          color: var(--ink-yellow)
        .trad, .name
          display: inline
      li[data-type='V']
        .type, .name
          color: var(--border-cyan)
      li[data-type='A']
        .type, .name
          color: var(--ink-green)
      li[data-type='D']
        .type, .name
          color: var(--ink-violet)
      li[data-type='N']
        .type, .name
          color: var(--yellow)
      li[data-type='P']
        .type, .name
          color: var(--ink-cyan)
      li[data-type='M'],li[data-type='I']
        .type, .name
          color: var(--green)
/* ----------------------------- END SASS */
{% endcapture %}
{{ style | sassify }}
</style>