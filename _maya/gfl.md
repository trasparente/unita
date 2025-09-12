---
order: 3
description: Git Football League, MZ meet BB
---
# Gfl

Basic for Plane maps and enerators of players, calendar, matches and playbooks.

> <https://github.com/fork-n-play/fork-n-play.github.io/wiki/GFL>
> <https://bbtactics.com/>

## Places

- Name: Match
  - Shape: line p (define origin for internal locuses)
  - Contains locuses:
    - off/def zones strat-o-matic
    - terrain: grass/mud/turf/ice...
    - wind: soft/medium/strong...
    - timer: 15
    - parts: 4

## Agents

- name: players
- shape: humanoid
- skills

## Entities (status)

- Teams
- Schedule
- Tournements

## Events (changers)

- Training
- Market
- Playbooks
- Matches sequence

## Fork: join

**Form {% include widgets/links/github_link.html path='gfl/join.yml' %}**
{% include widgets/form.html form=site.data.gfl.join %}
<fieldset><legend>Preview</legend>{% include svg/dow-join.svg %}</fieldset>
**Svg {% include widgets/links/github_link.html path='_includes/svg/gfl-join.svg' %}**

## Parent: team and players

**Form {% include widgets/links/github_link.html path='gfl/team.yml' %}**
{% include widgets/form.html form=site.data.gfl.team %}
**Form {% include widgets/links/github_link.html path='gfl/player.yml' %}**
{% include widgets/form.html form=site.data.gfl.player %}

## Fork: tactic