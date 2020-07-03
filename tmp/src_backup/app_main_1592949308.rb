def tick args
 
  #Set Default Variables
 
  left_border ||= args.grid.left
  right_border ||= args.grid.right
  top_border ||= args.grid.top
  bottom_border ||= args.grid.bottom
 
  #Define the Ball
  args.state.ball ||= [50, 50, 50, 50, 0, 0, 255]
 
  args.state.speed ||= 10
  args.state.alive ||= true
 
  #Run Movement Calculations
  if args.state.alive
    #Check if side wall collision is about to occur
    if (((args.state.ball[0] + args.state.speed) <= left_border) || (args.state.ball[0] + args.state.speed >= (right_border -args.state.ball[2])))
      #Bounce off of wall
      args.state.speed *= -1
    else
      #Move Ball
      args.state.ball[0] += args.state.speed
    end
 
    #Check if Top or Bottom wall collision is about to occur
    if (((args.state.ball[1] + args.state.speed) <= bottom_border) || (args.state.ball[1] + args.state.speed >= (top_border -args.state.ball[2])))
      #Bounce off wall
      args.state.speed *= -1
    else
      #move Ball
      args.state.ball[1] += args.state.speed
    end
   
    #Drawe to Screen
    args.outputs.solids << args.state.ball
    args.outputs.labels << [20, 20, args.state.ball[0]]
    args.outputs.labels << [40, 20, args.state.ball[1]]
  end
 
  #if args.inputs.mouse.click
end