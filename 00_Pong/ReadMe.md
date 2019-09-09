# Important Functions

*Sources:* `https://github.com/games50/pong`

* `love.load()`
- Used for initializing our game state at the very beginning of program execution.

* `love.update(dt)`
- Called each frame by LÖVE; `dt` (delta time) will be the elapsed time in seconds since
the last frame, and we can use this to scale any changes in our game for even behavior 
across frame rates.

* `love.draw()`
- Called each frame by LÖVE after update for drawing things to the screen once they’ve change

* `love.graphics.printf(text, x, y, [width], [align])`
Versatile print function that can align text left, right, or center on the screen.

* `love.window.setMode(width, height, params)`
Used to initialize the window’s dimensions and to set parameters like vsync (vertical sync), 
whether we’re fullscreen or not, and whether the window is resizable after startup.
Won’t be using past this example in favor of the push virtual resolution library,
which has its own method like this, but useful to know if encountered in other code.

`love.load()`, `love.update(dt)`, `love.draw()` - LÖVE2D expects these functions to be implemented
in `main.lua` and calls them internally;

