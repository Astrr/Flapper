def get_randomness(args)
  args.state.upper_height = rand(520)
  args.state.lower_height = (720 - 200) - args.state.upper_height
end

def jump(args)
  args.state.player_accel = 10
end

def gravity(args)
  args.state.player_accel = args.state.player_accel - args.state.gravity_coeff
  if args.state.player_y + args.state.player_accel <= 0
    args.state.player_accel = -args.state.player_accel - 5
    if args.state.player_accel.negative?
      args.state.player_accel = 0
    end
    args.state.player_y = 0
  end
  if args.state.player_y + args.state.player_accel >= 656
    args.state.player_accel = -args.state.player_accel + 5
    if args.state.player_accel.positive?
      args.state.player_accel = 0
    end
    args.state.player_y = 656
  end
end

def move_player(args)
  args.state.player_y += args.state.player_accel
  args.state.player.h = 64 * ((1 - args.state.player_accel/100))
end

def generate_pipes(args)
  get_randomness(args)
  args.state.pipes << [2000, 0, 100, args.state.upper_height]
  args.state.pipes << [2000, 720 - args.state.lower_height, 100, 720]
end

def update_pipes(args)
  return unless args.state.dead == 0

  args.state.pipes.each { |w| w.x -= 8 }
end

def tick(args)
  args.state.dead ||= 0
  args.outputs.solids << [0, 0, 1280, 720, 50, 130, 190]
  args.state.pipes ||= []
  args.state.pipe_timer ||= 70
  args.state.pipe_timer -= 1
  if args.state.pipe_timer.zero? and args.state.dead == 0
    generate_pipes(args)
    args.state.pipe_timer = 100
  end
  # args.outputs.labels << [100, 100, args.state.player_accel]
  args.state.player_x ||= 100
  args.state.player_y ||= 360
  args.state.player_accel ||= 0
  args.state.gravity_coeff ||= 0.5
  args.state.player = {
    x: args.state.player_x, # X
    y: args.state.player_y, # Y
    w: 64, # WIDTH
    h: 64, # HEIGHT
    path: 'sprites/circle-violet.png'
  }
  #args.state.player.rect = [args.state.player.x, args.state.player.y, args.state.player.h, args.state.player.w]
  #args.state.pipes.each do |p|
  #  p.rect = [p.x, p.y, p.w, p.h]
  #end
  get_randomness(args)
  update_pipes(args)
  gravity(args)
  reset_game(args) if args.inputs.keyboard.key_down.r
  jump(args) if args.inputs.keyboard.key_down.a and args.state.dead == 0
  move_player(args)
  if args.state.pipes.any? { |p| p.rect.intersect_rect?(args.state.player.rect) }
     player_ded args
  end
  args.outputs.solids << args.state.pipes
  args.outputs.background_color = [58, 47, 20]
  args.outputs.sprites << args.state.player
end

def reset_game(args)
  args.state.pipes = []
  args.state.dead = 0
  args.state.pipe_timer = 70
  args.state.player_accel = 0
  args.outputs.solids.clear
  args.state.dead = 0
  args.state.player_y = 410
end

def player_ded(args)
  args.state.dead = 1
  args.outputs.labels << [100, 100, "U ded, press R to retry"]
end