## Functions to be implemented in main.lua

* `love.load()`

  -Used for initializing our game state at the very beginning of program execution.

* `love.update(dt)`

  -Called each frame by LÖVE;

  `dt` will be the elapsed time in seconds since the last frame,
  and we can use this to scale any changes in our game for even behavior across frame rates.

* `love.draw()`

  -Called each frame by LÖVE after update for drawing things to the screen once they’ve changed.

LÖVE2D expects these three functions to be implemented in main.lua and calls them internally;
if we don’t define them, it will still function, but our game will be fundamentally incomplete,
at least if update or draw are missing!


## Important Functions

* `love.graphics.printf(text, x, y, [width], [align])`

  -Versatile print function that can align text left, right, or center on the screen.

* `love.window.setMode(width, height, params)`

  -Used to initialize the window’s dimensions and to set parameters like `vsync` (vertical sync),
  whether we’re *fullscreen* or not, and whether the window is *resizable* after startup.

  Won’t be using past this example in favor of the push virtual resolution library,
  which has its own method like this, but useful to know if encountered in other code.

* `love.graphics.setDefaultFilter(min, mag)`

  -Sets the texture scaling filter when minimizing and magnifying textures and fonts;

  default is `"bilinear"`, which causes blurriness, and for our use cases we will typically
  want nearest-neighbor filtering (`"nearest"`), which results in perfect
  pixel upscaling and downscaling, simulating a retro feel.

* `love.keypressed(key)`

  -A LÖVE2D callback function that executes whenever we press a key,

* `love.event.quit()`

  -Simple function that terminates the application.

*  `love.graphics.newFont(path, size)`

  -Loads a font file into memory at a specific path, setting it to a specific size,
  and storing it in an object we can use to globally change the currently active font
  that LÖVE2D is using to render text (functioning like a state machine).

* `love.graphics.setFont(font)`

  -Sets LÖVE2D’s currently active font (of which there can only be one at a time)
  to a passed-in font object that we can create using `love.graphics.newFont`.

* `love.graphics.clear(r, g, b, a)`

  -Wipes the entire screen with a color defined by an RGBA set,
  each component of which being from 0-1.

* `love.graphics.rectangle(mode, x, y, width, height)`

  -Draws a rectangle onto the screen using whichever our active color is
  (`love.graphics.setColor`, which we don’t need to use in this particular project
  since most everything is *white*, the default LÖVE2D color).

  `mode` can be set to `"fill"` or `"line"`, which result in a filled or outlined rectangle,
  respectively; 

  the other four parameters are its position and size dimensions.

* `love.keyboard.isDown(key)`

  -Returns `true` or `false` depending on whether the specified key is currently held down;

  differs from `love.keypressed(key)` in that this can be called arbitrarily
  and will continuously return true if the key is pressed down, where `love.keypressed(key)`
  will only fire its code once every time the key is initially pressed down.

* `math.randomseed(num)`

  -”Seeds” the random number generator used by Lua (`math.random`) with some value
  such that its randomness is dependent on that supplied value.

* `os.time()`

  -Lua function that returns, in seconds, the time since 00:00:00 UTC, January 1, 1970.

* `math.random(min, max)`

  -Returns a random number, dependent on the seeded random number generator,
  between `min` and `max`, inclusive.

* `math.min(num1, num2)`

  -Returns the lesser of the two numbers passed in.

* `math.max(num1, num2)`

  -Returns the greater of the two numbers passed in.

* `love.window.setTitle(title)`

  -Simply sets the title of our application window.

* `love.timer.getFPS()`

  -Returns the current FPS of our application.

* `love.audio.newSource(path, [type])`

  -Creates a LÖVE2D Audio object that we can play back at any point in our program.

  Can also be given a `type` of `"stream"` or `"static"`;
  streamed assets will be streamed from disk as needed,
  whereas static assets will be preserved in memory.

  For larger sound effects and music tracks, streaming is more memory-effective;
  Audio assets are static if they’re so small that they won’t take up much memory at all.

* `love.resize(width, height)`

  -Called by LÖVE every time we resize the application;
  logic should go in here if anything in the game (like a UI) is
  sized dynamically based on the window size.

  `push:resize()` needs to be called here for our use case so that it can
   dynamically rescale its internal canvas to fit our new window dimensions.

## Links

* https://love2d.org/wiki/Getting_Started
* https://github.com/games50
* https://www.bfxr.net (Simple sound-generating program)

### Libs

* https://github.com/Ulydev/push

  push is a library that will allow us to draw our game at a virtual
  resolution, instead of however large our window is; used to provide
  a more retro aesthetic.

* https://github.com/vrld/hump/blob/master/class.lua

  The "Class" library we're using will allow us to represent anything in
  our game as code, rather than keeping track of many disparate variables and
  methods.

* https://github.com/bjornbytes/tick

  Gives love.run superpowers, including a fixed timestep model and framerate limiting.
