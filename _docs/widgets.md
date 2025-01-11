---
order: 2
---
# Widgets
{:.no_toc}
- toc
{:toc}
{% include widgets/api.html include='widgets/time' %}
- {% include widgets/time.html datetime='2025-01-07T08:00:00' duration='P2W' text='Blue' %}
- {% include widgets/time.html datetime='2025-01-09T08:00:00' duration='P2W' text='Black' %}
- {% include widgets/time.html datetime='2025-01-01T08:00:00' duration='P2W' text='Yellow' %}
- {% include widgets/time.html datetime='2024-12-21T08:00:00' duration='P4W' text='Green' %}
{% include widgets/api.html include='widgets/rolls' %}
- Default rolls {% include widgets/rolls.html %}, array {{ rolls_rolls | inspect }}
{% include widgets/api.html include='widgets/form' %}
```liquid
{% raw %}{% include widgets/form.html form=site.data.form %}{% endraw %}
```
{% include widgets/form.html form=site.data.form %}