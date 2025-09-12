---
permalink: settings/
proportion:
  a:
    type: number
    title: A stay to
  b:
    type: number
    title: B, like...
  c:
    type: number
    title: C stay to
  d:
    type: number
    title: D
---
# Settings

{% assign sort_by = 'order' %}
{% assign repo = site.github.public_repositories | where: "full_name", site.github.repository_nwo | first %}

<fieldset markdown=1><legend>Repository</legend>
- [{{ site.github.repository_nwo }}]({{ site.github.repository_url }})
- Owner type `{{ repo.owner.type }}`
- Owner name `{{ site.github.owner_name }}`
- Page type `{% if site.github.is_user_page %}User{% endif %}{% if site.github.is_project_page %}Project{% endif %}`
- Fork `{{ repo.fork | inspect }}`
- Release `{{ site.github.releases | first | map: 'tag_name' | default: '-' }}` `{{ site.github.releases | first | map: 'name' | default: '-' }}`
- Created <code>{% include widgets/time.html datetime=repo.created_at %}</code>
- Modified <code>{% include widgets/time.html datetime=repo.modified_at %}</code>
- Site build <code>{% include widgets/time.html datetime=site.time %}</code>
</fieldset>

{% assign html_pages = site.html_pages | sort: 'order' %}
{% assign sorted_collections = site.collections | sort: 'order' %}

<fieldset markdown=1><legend>Pages</legend>
{% assign html_sorted = html_pages | sort: sort_by %}{% for item in html_sorted %}- `{{ item[sort_by] | inspect }}` {{ item.title | default: item.name }}
{% endfor %}
</fieldset>

<fieldset markdown=1><legend>Collections</legend>
{% for collection in sorted_collections %}- `{{ collection.order | inspect }}` {{ collection.title | default: collection.label }} ({{ collection.docs.size }} documents){% assign collection_docs = collection.docs | sort: sort_by %}{% for p in collection_docs %}
  - `{{ p[sort_by] | inspect }}` {{ p.title | default: p.path }}{% endfor %}
{% endfor %}
</fieldset>

<fieldset markdown=1><legend>Static files</legend>
{% assign folder_assets = site.static_files | group_by_exp: "item", "item.path | replace: item.name, ''" %}
<ul>{% for folder in folder_assets %}
  <li>Folder <code>{{ folder.name }}</code></li>
  <ul>{% for file in folder.items %}
    <li><code>{{ file.name }}</code></li>
  {% endfor %}</ul>
{% endfor %}</ul>
</fieldset>

{% include widgets/input.html %}

{% if true %}
<fieldset markdown=1><legend>Remote theme</legend>
- Repository [{{ site.remote_theme | split: '@' | first }}]({{ site.remote_theme | split: '@' | first }})
- Branch `{{ site.remote_theme | split: '@' | last | default: '-' }}`
- Plugin [jekyll-remote-theme](https://github.com/benbalter/jekyll-remote-theme) {{ site.github.versions["jekyll-remote-theme"] }}
</fieldset>
{% endif %}