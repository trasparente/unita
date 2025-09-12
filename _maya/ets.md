---
order: 4
description: Enemy Territory Squads, ET meets Squad Leader
---
# ETS

Basic for Plane maps, terrains, units movement and war.

> - Classes and weapons: <https://strategywiki.org/wiki/Wolfenstein:_Enemy_Territory/Classes>
> - Voice commands: <https://eurotoxic.wordpress.com/2009/10/06/wolfenstein-enemy-territory-quick-chats/>

## Places

- Name: World
- Shape: plane xy (define origin for internal locuses)
- Contains locuses:
  - x, y (define origin for internal lacuses)
  - terrain
    - state: liquid/solid/gas...
    - material: water/earth/sand/rock...
    - vegetation: grass/forest...
  - building
    - purpose: factory, quarters, church, basament...

## Agents

- name: Soldiers
- shape: humanoid
- skills

## Modifiers should go on Sons and are tables themselves

- purpose: (movement, offence)
- Fixed:
  - operation and factor (minus 2, divided_by 2)
- Variable
  - table url

## Status

> Boundary, Goal, Land

- Fireteams
  - TL: Team Leader, AR: Automatic Rifleman, Grenadier: GR, Rifleman: R, DM: Designated Marksman, Anti Armour Specialist: AAS...
- Squad
  - small military unit typically containing two or more fire teams. It typically contains a dozen Soldiers or less
- Squad groups, Friendly Fire disabled (timeout if want to change)

## Changers

> Nod Command Will

- Voice, scheduled, generated

## Fork: join

**Form {% include widgets/links/github_link.html path='dow/join.yml' %}**
{% include widgets/form.html form=site.data.dow.join %}
<fieldset><legend>Preview</legend>{% include svg/dow-join.svg %}</fieldset>
**Svg {% include widgets/links/github_link.html path='_includes/svg/dow-join.svg' %}**

## Parent: world

**Form {% include widgets/links/github_link.html path='dow/world.yml' %}**
{% include widgets/form.html form=site.data.dow.world %}

## Fork: round