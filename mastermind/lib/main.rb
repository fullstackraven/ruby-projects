# This code is written in Ruby and uses the 'ruby2d' library to create a Mastermind game.

require 'ruby2d'

# Set up the window properties.
set title: 'Mastermind',
    width: 900,
    height: 900,
    resizable: false,
    background: 'white'

# Add images to window.
start_game = Image.new(
  'img/start_game.png',
  x: 5,
  y: 250,
  width: 900,
  height: 400,
  z: 1
)

start_game_clicked = Image.new(
  'img/start_game_click.png',
  x: 5,
  y: -9999, # Off screen until 'clicked'.
  width: 900,
  height: 400,
  z: 1
)

logo = Image.new(
  'img/mastermind_logo.png',
  x: 200,
  y: -9999, # Off screen until 'clicked'.
  width: 500,
  height: 200,
  z: 10
)

rules = Image.new(
  'img/rules.png',
  x: 10,
  y: -9999, # Off screen until 'clicked'.
  width: 950,
  height: 900,
  z: 1
)

clues = Image.new(
  'img/clues.png',
  x: 10,
  y: -9999, # Off screen until key pressed.
  width: 950,
  height: 900,
  z: 1
)

# Event handler for mouse click down on main screen button.
# Removes initial image and brings 'clicked' image onto Window.
# Creates button 'clicked' affect.
on :mouse_down do |event|
  if event.x > 270 && event.x < 640 && event.y > 530 && event.y < 590
    start_game.remove
    start_game_clicked.y = 250
  end
end

# Event handler for mouse click up on main screen button.
# Removes 'clicked' image and brings logo & rules image onto Window.
on :mouse_up do |event|
  if event.x > 270 && event.x < 640 && event.y > 530 && event.y < 590
    start_game_clicked.remove
    logo.y = -50
    rules.y = 100
  end
end

# Event handler for key click on rules screen button.
# Removes rules image and brings 'clues' image onto Window.
# if the 'm' key is pressed, user becomes the maker.
# if the 'b' key is pressed, user becomes the breaker.
on :key_down do |event|
  if event.key == 'c'
    rules.remove
    clues.y = 150
  elsif event.key == 'm'
    # add code for maker
    clues.remove
  elsif event.key == 'b'
    # add code for breaker
    clues.remove
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
