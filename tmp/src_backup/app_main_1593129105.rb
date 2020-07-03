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
  if args.state.player_y + args.state.player_accel >= 688
    args.state.player_accel = -args.state.player_accel + 5
    if args.state.player_accel.positive?
      args.state.player_accel = 0
    end
    args.state.player_y = 688
  end
end

def move_player(args)
  args.state.player_y += args.state.player_accel
  args.state.player.h = 32 * ((1 - args.state.player_accel/100))
end

def generate_pipes(args)
  get_randomness(args)
  args.state.pipes << [1300, 0, 100, args.state.upper_height, 65, 65, 65]
  args.state.pipes << [1300, 720 - args.state.lower_height, 100, 720, 65, 65, 65]
end

def update_pipes(args)
  return unless args.state.dead.zero?

  args.state.pipes.each { |w| w.x -= 8 }
end

def init_player(args)
  args.state.player_x ||= 100
  args.state.player_y ||= 360
  args.state.player_accel ||= 0
  args.state.gravity_coeff ||= 0.5
  args.state.player = {
    x: args.state.player_x, # X
    y: args.state.player_y, # Y
    w: 64, # WIDTH
    h: 64, # HEIGHT
    path: 'sprites/frame1-cscaled.png'
  }
end

def tick(args)
  args.state.player_score ||= 0
  args.outputs.background_color = [244, 204, 65]
  args.state.flap ||= 0
  args.state.dead ||= 0
  args.outputs.solids << [0, 0, 1280, 720, 50, 130, 190]
  args.state.pipes ||= []
  args.state.pipe_timer ||= 70
  args.state.pipe_timer -= 1
  if args.state.pipe_timer.zero? && args.state.dead.zero?
    generate_pipes(args)
    args.state.pipe_timer = 100
  end
  init_player(args)
  get_randomness(args)
  update_pipes(args)
  gravity(args)
  reset_game(args) if args.inputs.keyboard.key_down.r
  if args.inputs.mouse.click && args.state.dead == 1
    reset_game(args)
  end
  if (args.inputs.keyboard.key_down.space && args.state.dead.zero?) || (args.inputs.mouse.click && args.state.dead.zero?)
    jump args
    args.state.flap = 1
  end
  animate_player args
  move_player(args)
  if args.state.pipes.any? { |p| p.rect.intersect_rect?(args.state.player.rect) } || args.state.dead == 1
    player_ded args
    args.outputs.background_color = [244, 204, 65]
  end
  pipes_count_before_removal = args.state.pipes.length

  args.state.pipes.reject! { |w| w.x < -100 }

  args.state.player_score += 1 if args.state.pipes.count < pipes_count_before_removal
  args.outputs.solids << args.state.pipes
  args.outputs.sprites << args.state.player
  args.outputs.background_color = [244, 204, 65]
  args.outputs.labels << [100, 700, args.state.player_score, 3, 0, 0, 0, 0]
end

def reset_game(args)
  args.state.player_x = 100
  args.state.player_y = 360
  args.state.player_accel = 0
  args.state.gravity_coeff = 0.5
  args.state.pipes = []
  args.state.dead = 0
  args.state.pipe_timer = 70
  args.state.player_accel = 0
  args.outputs.solids.clear
  args.state.dead = 0
end

def player_ded(args)
  args.outputs.background_color = [244, 204, 65]
  args.state.dead = 1
  args.outputs.labels << [640, 360, 'You died, press R or tap the screen to retry', 3, 1, 0, 0, 0]
  args.outputs.background_color = [244, 204, 65]
end

def animate_player(args)
  if args.state.flap == 1
    args.state.flap = 0
    args.state.anim_in_progress = 1
    args.state.anim_frame = 0
    args.state.counter_frame = 0
  end
  if args.state.anim_in_progress
    case args.state.anim_frame
    when 0
      args.state.player.path = 'sprites/frame2-cscaled.png'
    when 1
      args.state.player.path = 'sprites/frame3-cscaled.png'
    when 2
      args.state.player.path = 'sprites/frame4-cscaled.png'
    when 3
      args.state.player.path = 'sprites/frame3-cscaled.png'
    when 4
      args.state.player.path = 'sprites/frame2-cscaled.png'
    when 5
      args.state.player.path = 'sprites/frame1-cscaled.png'
      args.state.anim_in_progress = 0
    end
    if args.state.counter_frame == 2
      args.state.anim_frame += 1
      args.state.counter_frame = 0
    end
    args.state.counter_frame += 1
  end
end
