---
order: 2
---
- toc
{:toc}
# Widgets
{:.no_toc}
{% include widgets/api.html include='widgets/time' %}
<div class='example' markdown=1>
```liquid
{% raw %}{% include widgets/time.html datetime='2025-01-07T08:00:00' duration='P2W' text='Blue' %}{% endraw %}
```
- {% include widgets/time.html datetime='2025-01-07T08:00:00' duration='P2W' text='Blue' %}
- {% include widgets/time.html datetime='2025-01-09T08:00:00' duration='P2W' text='Black `long`' style='long' %}
- {% include widgets/time.html datetime='2025-01-01T08:00:00' duration='P2W' text='Yellow `short`' style='short' %}
- {% include widgets/time.html datetime='2024-12-21T08:00:00' duration='P4W' text='Green `narrow`' style='narrow' %}
</div>
{% include widgets/api.html include='widgets/rolls' %}
<div class='example' markdown=1>
- Default rolls {% include widgets/rolls.html %}, array {{ rolls_rolls | inspect }}
</div>
{% include widgets/api.html include='widgets/view' %}
{% include widgets/api.html include='widgets/progress' %}
<fieldset><legend>progress</legend>
{%- include widgets/progress.html -%}
{%- include widgets/progress.html max=100 value=9 label='Info' class='info' -%}
{%- include widgets/progress.html max=100 value=68 label=1 class='success' -%}
{%- include widgets/progress.html max=100 value=72 label=1 class='warning' -%}
{%- include widgets/progress.html max=100 value=84 label=1 class='error' -%}
</fieldset>
{% include widgets/api.html include='widgets/toc' %}
{% include widgets/api.html include='widgets/form' %}
<div class='example' markdown=1>
```liquid
{% raw %}{% include widgets/form.html form=site.data.form %}{% endraw %}
```
{% include widgets/form.html form=site.data.form %}
</div>
{% include widgets/api.html include='widgets/input' %}
{% include widgets/api.html include='widgets/aside' %}
{% include widgets/api.html include='widgets/pagination' %}
{% include svg/number.svg number=16 %}