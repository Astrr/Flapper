def jump(args)
  args.state.player_accel = 10
end

def gravity(args)
  args.state.player_accel = args.state.player_accel - args.state.gravity_coeff
end

def move_player(args)
  args.state.player_y += args.state.player_accel
end

def generate_pipe
end

def tick(args)
  args.outputs.labels << [100, 100, args.state.player_accel]
  args.state.player_x ||= 100
  args.state.player_y ||= 360
  args.state.player_accel ||= 0
  args.state.gravity_coeff ||= 0.5

  args.state.player = [
    args.state.player_x, # X
    args.state.player_y, # Y
    64, # WIDTH
    64, # HEIGHT
    'sprites/circle-violet.png'
  ]
  jump(args) if args.inputs.keyboard.key_down.a
  gravity(args)
  move_player(args)
  args.outputs.background_color = [50, 130, 190]
  args.outputs.sprites << args.state.player
end