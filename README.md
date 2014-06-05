# ExSimcity

## Requirements:

Elixir 0.14ish?

The following entities exist in the system: (lol not yet)

- Map
- MapCell
- Actor
  - Power
- Structures
  - Road
  - Power Plant
  - House


### Simple example
- A Power Plant is a Structure.
- It emits a Power Actor that carry 1 resource along roads.
- Structures check to see if there is a resource they need, if there is, they consume it.
