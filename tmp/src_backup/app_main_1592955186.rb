def tick(args)
  args.state.player ||= [
  100, # X
  100, # Y
  64, # WIDTH
  64, # HEIGHT
  "sprites/circle-violet.png"
  ]
  args.outputs.background_color = [50, 130, 190]
  args.outputs.sprites << args.state.player
end
