---
order: 0
description: Outward genesi of Hexroses
locus:
  file_extension:
    type: hidden
    value: json
  file_name:
    type: hidden
    value: locus
  file_path:
    type: hidden
    slug: name
  name:
    type: text
    required: true
  shape:
    type: radio
    description: Locus form
    options:
      - Point
      - Line
      - Orbit
      - Plane
      - Sphere
      - Space
    descriptions:
      - Dimensions 0, no coordinates
      - Dimensions 1, position `p` form origin `o`
      - Dimensions 1, Hexrose of radius `r`
      - Dimensions 2, Hexrose of radius `r`, position `x,y` form `o`
      - Dimensions 2, Hexrose for each emisphere, position `x,y` from `o`
      - Dimensions 3, Hexrose planar and Triroses up and down, position `x,y,z` from `o`
---
# Hexrose

- `Center/Focus GreatActivity/IntenseConcentration`

**Hexes shown**

|Limit|1D    |2D        | 3D
|----:|-----:|---------:|------:
| 1   |2+1   |6+1       |+3+3
| 2   |2+2+1 |12+6+1    |3 = 6f + 3u + 3d + 1)
| 3   |3+3+1 |18+12+6+1 |

{% include widgets/input.html form=page.locus %}

## ToDo

- EC, EsaChess 6*6 pawn 1 row ahead
- Archon on hexes <https://www.c64-wiki.com/wiki/Archon>

## Old

Create the file: `<name-slug>/map.json` with properties:
- `name`
- `shape`
  - Point: 0D, no coordinates
  - Line: 1D, `p` from origin
  - Orbit: 1D [hex rose], `r` orbit radius, keplerian has stable `v`
  - Plane: 2D [hex rose] or [limits], `x,y` from origin
  - Sphere: 2D [2 hex roses], `x,y` from origin
  - Space: 3D, [hex rose] and 2 x [3 hex poles] or [limits], `x,y,z` from origin

## hierarchy

- Universe (point)
  - Black Hole (space) [type, diameter, mass]
  - Galaxy (circle)
    - Cloud (space) [type, diameter, mass]
    - System (orbit) [orbit]
      - Star (orbit) [coordinates, type, diameter, mass]
        - Belt (orbit) [type, orbit]
        - System (orbit) [type, orbit]
          - Moon (sphere) [type, diameter, mass]
          - Planet (sphere) [type, diameter, mass]
            - Hexes (plane) [coordinates, type]
              - City (plane) [coordinates, type, population]