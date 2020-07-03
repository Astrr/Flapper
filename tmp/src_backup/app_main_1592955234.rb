def tick(args)
  args.state.player_x ||= 100
  args.state.player_y ||= 100
  args.state.player = [
  player_x, # X
  player_y, # Y
  64, # WIDTH
  64, # HEIGHT
  "sprites/circle-violet.png"
  ]
  args.outputs.background_color = [50, 130, 190]
  args.outputs.sprites << args.state.player
end
