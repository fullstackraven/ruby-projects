require 'ruby2d'

set title: 'Hangman',
    width: 800,
    height: 800,
    resizable: true,
    background: 'olive'

image = Image.new(
    'img/hangman_board.png',
    x: 0,
    y: 0,
    width: Window.width,
    height: Window.height,
    z: 1

)
image.add

show