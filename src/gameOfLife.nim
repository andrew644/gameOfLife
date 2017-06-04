import
  nimgame2 / [
    nimgame,
    scene
  ],
  main

var mainScene*: Scene

const
  GameWidth* = 800
  GameHeight* = 600

game = newGame()
if game.init(GameWidth, GameHeight, title = "Conway's Game of Life", integerScale = true):

  # Init
  game.setResizable(true) # Window could be resized
  game.minSize = (GameWidth, GameHeight) # Minimal window size
  game.windowSize = (GameWidth, GameHeight)
  game.centrify() # Place window at the center of the screen

  # Create scenes
  mainScene = newMainScene()

  # Run
  game.scene = mainScene # Initial scene
  run game  # Let's go!



