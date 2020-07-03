def jump(args)
end

def gravity(args)
  args.state.player_accel -= args.state.gravity_coeff
  args.state.player_y -= args.state.player_accel
end

def tick(args)
  args.state.player_x ||= 100
  args.state.player_y ||= 360
  args.state.player_accel = 0
  args.state.gravity_coeff = -5

  args.state.player = [
    args.state.player_x, # X
    args.state.player_y, # Y
    64, # WIDTH
    64, # HEIGHT
    'sprites/circle-violet.png'
  ]
  gravity(args)
  args.outputs.background_color = [50, 130, 190]
  args.outputs.sprites << args.state.player
end