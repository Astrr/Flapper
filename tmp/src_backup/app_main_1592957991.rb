def get_randomness(args)
  args.state.upper_height = rand(100..620
  )
  args.state.lower_height = 720 - args.state.upper_height
end
def jump(args)
  args.state.player_accel = 10
end

def gravity(args)
  args.state.player_accel = args.state.player_accel - args.state.gravity_coeff
end

def move_player(args)
  args.state.player_y += args.state.player_accel
end

def generate_pipes(args)
  args.outputs.solids << [1000, 0, 100, args.state.upper_height]
  args.outputs.solids << [1000, 720, 100, -args.state.lower_height + 100]
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
  get_randomness(args)
  generate_pipes(args)
  jump(args) if args.inputs.keyboard.key_down.a
  gravity(args)
  move_player(args)
  args.outputs.background_color = [50, 130, 190]
  args.outputs.sprites << args.state.player
end
