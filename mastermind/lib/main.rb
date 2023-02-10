# This code is written in Ruby and uses the 'ruby2d' library to create a Mastermind game.

require 'ruby2d'

# Set up the window properties.
set title: 'Mastermind',
    width: 900,
    height: 900,
    resizable: false,
    background: 'white'

# Method to handle image creation on Window
def create_image(img_file, x, y, w, h, z)
  image = Image.new(
    img_file,
    x: x,
    y: y,
    width: w,
    height: h,
    z: z
  )

  # Event handler for mouse click down on main screen button.
  # Removes initial image and brings 'clicked' image onto Window.
  # Creates button 'clicked' effect.
  on :mouse_down do |event|
    if event.x > 270 && event.x < 640 && event.y > 530 && event.y < 590
      @start_game.remove
      @start_game_clicked.y = 250
    end
  end

  # Event handler for mouse click up on main screen button.
  # Removes 'clicked' image and brings logo & rules image onto Window.
  on :mouse_up do |event|
    if event.x > 270 && event.x < 640 && event.y > 530 && event.y < 590
      @start_game_clicked.remove
      @logo.y = -50
      @rules.y = 100
    end
  end

  return image
end

# Add images to window.
@start_game = create_image('img/start_game.png', 5, 250, 900, 400, 1)
@start_game_clicked = create_image('img/start_game_click.png', 5, -9999, 900, 400, 1)
@logo = create_image('img/mastermind_logo.png', 200, -9999, 500, 200, 10)
@rules = create_image('img/rules.png', 10, -9999, 950, 900, 10)
@clues = create_image('img/clues.png', 10, -9999, 950, 900, 1)
@maker = create_image('img/maker.png', 20, -9999, 950, 900, 10)
@master_code_set = create_image('img/master_code_set.png', 200, -9999, 500, 200, 1)

# Hash to map each key to its corresponding image file
PEG_IMAGE_MAP = {
  '1' => 'red_peg',
  '2' => 'blue_peg',
  '3' => 'green_peg',
  '4' => 'yellow_peg',
  '5' => 'orange_peg',
  '6' => 'purple_peg'
}

@peg_placement = [[350,485], [400,485], [450,485], [500,485], [550,485], [600,485]] 
@peg_choice = []
@created_pegs = []
@master_code = []
@counter = 0

# Event handler for key click on rules, clues and maker screens.
# Removes rules image and brings 'clues' image onto Window, if 'c' is pressed.
# if the 'm' key is pressed, user becomes the maker.
# if the 'b' key is pressed, user becomes the breaker.
on :key_down do |event|
  if event.key == 'c'
    @rules.remove
    @clues.y = 150
  elsif event.key == 'm'
    # add code for maker
    @clues.remove
    @maker.y = 0
  elsif event.key == 'b'
    # add code for breaker
    @clues.remove
  end

# Conditional logic for choosing the master code and displaying colored pegs.
  if PEG_IMAGE_MAP.keys.include?(event.key) && @counter < 4
    @counter += 1
    if @counter >= 4
      @master_code_set.y = 550
    end
    @master_code << event.key
    next_peg = @peg_placement[@peg_choice.size]
    unless @created_pegs.include?(next_peg)
      @peg_choice << event.key
      peg_color = PEG_IMAGE_MAP[event.key]
      peg = Image.new(
        "img/pegs/#{peg_color}.png",
        x: next_peg[0],
        y: next_peg[1],
        height: 30,
        width: 30
      )
      peg.add
      @created_pegs << next_peg
    end
  end
end

# Background falling squares affect.
# Store square objects, and a random number of square objects are generated and stored in the array.
squares = []

@x_speed = 0
@y_speed = 0

num_squares = rand(500..1000)
num_squares.times do
  x = rand(0..Window.width)
  y = rand(-9999..Window.height)
  squares << Square.new(x: x, y: y, size: 25, color: 'gray', opacity: rand(0.01..0.5), z: -9999)
end

# Event handler is set up to detect key presses and change the speed of the squares in response.
on :key_down do |event|
  if event.key == 'left'
    @x_speed = -2
    @y_speed = 0
  elsif event.key == 'right'
    @x_speed = 2
    @y_speed = 0
  elsif event.key == 'up'
    @x_speed = 0
    @y_speed = -2
  elsif event.key == 'down'
    @x_speed = 0
    @y_speed = 2
  end
end

# Ruby2D built-in loop method that handles setting random falling affect speed, adds squares
# and sets speed according to the above key events.
update do
  squares.each do |square|
    square.y += rand(0.01..1)
    square.add
    square.x += @x_speed
    square.y += @y_speed
  end
end

show