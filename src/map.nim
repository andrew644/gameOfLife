const mapWidth* = 200
const mapHeight* = 150

type
  Map* = array[mapHeight, array[mapWidth, bool]]

proc setupMap*(map: var Map) =
  map[5][5] = true
  map[6][6] = true
  map[7][4] = true
  map[7][5] = true
  map[7][6] = true

proc east(x: int): int =
  return (x + 1) %% mapWidth

proc west(x: int): int =
  return (x - 1 + mapWidth) %% mapWidth

proc north(y: int): int =
  return (y - 1 + mapHeight) %% mapHeight

proc south(y: int): int =
  return (y + 1) %% mapHeight

proc numberAdjacent(map: Map, x: int, y: int): int =
  # TODO see if this can be done with less code
  let
    east = east(x)
    west = west(x)
    north = north(y)
    south = south(y)

  var numAdjacent = 0
  if map[north][west]:
    numAdjacent += 1

  if map[north][x]:
    numAdjacent += 1

  if map[north][east]:
    numAdjacent += 1

  if map[y][west]:
    numAdjacent += 1

  if map[y][east]:
    numAdjacent += 1

  if map[south][west]:
    numAdjacent += 1

  if map[south][x]:
    numAdjacent += 1

  if map[south][east]:
    numAdjacent += 1

  return numAdjacent

proc step*(map: var Map) =
  var nextMap: Map
  for y, row in map:
    for x, cell in row:
      if map[y][x]:
        case numberAdjacent(map, x, y)
        of 2, 3:
          nextMap[y][x] = true
        else:
          nextMap[y][x] = false
      elif numberAdjacent(map, x, y) == 3:
        nextMap[y][x] = true

  map = nextMap
