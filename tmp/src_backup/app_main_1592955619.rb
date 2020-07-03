def tick(args)
  args.state.player_x ||= 100
  args.state.player_y ||= 360
  args.state.player_accel = 0
  args.state.gravity = 1

  args.state.player = [
    args.state.player_x, # X
    args.state.player_y, # Y
    64, # WIDTH
    64, # HEIGHT
    'sprites/circle-violet.png'
  ]
  args.outputs.background_color = [50, 130, 190]
  args.outputs.sprites << args.state.player
end

def jump(args)
end

def gravity(args)
  args.state.player_accel -= args.state.gravity
  args.state.player_y -= args.state.player_accel
end