def generate_player(args)
  args.state.player = [
  100, # X
  100, # Y
  32, # WIDTH
  32, # HEIGHT
  "sprites/circle-violet.png"
  ]
end

def tick(args)
  args.outputs.background_color = [50, 130, 190]
  args.outputs.sprites << args.state.player
end

generate_player(args)
