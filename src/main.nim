import
  nimgame2 / [
    input,
    scene,
    types,
    draw
  ],
  map

const
  cellHeight = 4
  cellWidth = 4

type
  MainScene = ref object of Scene
    map: Map
    totalElapsed: float
    paused: bool
    stepTime: float


proc init*(scene: MainScene) =
  init Scene(scene)
  scene.map.setupMap()
  scene.totalElapsed = 0.0
  scene.paused = false
  scene.stepTime = 0.05

proc free*(scene: MainScene) =
  discard

proc newMainScene*(): MainScene =
  new result, free
  init result

proc setCellUnderMouse(scene:MainScene, newState: bool) =
  let x: int = mouse.abs.x.int div cellWidth
  let y: int = mouse.abs.y.int div cellHeight
  if x >= 0 and x < mapWidth and y >= 0 and y < mapHeight:
    scene.map[y][x] = newState

method event*(scene: MainScene, event: Event) =
  if event.kind == KeyDown:
    case event.key.keysym.sym:
    of K_p:
      scene.paused = not scene.paused
    of K_PERIOD:
      scene.stepTime -= 0.01
      if scene.stepTime < 0:
        scene.stepTime = 0
    of K_COMMA:
      scene.stepTime += 0.01
      if scene.stepTime > 10:
        scene.stepTime = 10
    else: discard

method show*(scene: MainScene) =
  discard


method update*(scene: MainScene, elapsed: float) =
  scene.updateScene(elapsed)
  scene.totalElapsed += elapsed
  if scene.totalElapsed > scene.stepTime:
    if not scene.paused:
      scene.map.step()
    scene.totalElapsed = 0

  if MouseButton.left.down:
    setCellUnderMouse(scene, true)

  if MouseButton.right.down:
    setCellUnderMouse(scene, false)


method render*(scene: MainScene) =
  scene.renderScene()
  for y, row in scene.map:
    for x, cell in row:
      if cell:
        discard draw.box((int(x * cellWidth),int(y * cellHeight)), (int(x * cellWidth + cellWidth - 1),int(y * cellHeight + cellHeight - 1)), 0xFFFFFFFF'u32)

