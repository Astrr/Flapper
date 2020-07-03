def tick(args)
  args.outputs.background_color = [50, 130, 190]
end

def generate_player(args)
  player = [
  100, # X
  100, # Y
  32, # WIDTH
  32, # HEIGHT
  "sprites/circle-violet.png"
  ]
end

generate_player(args)
