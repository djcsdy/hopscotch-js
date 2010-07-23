class Playfield
  ticksPerSecond: 100
  constructor: ->
    @objects: []
  start: =>
    unless @tickInterval?
      @gameTime: new Date().getTime()
      @tickIntervalMs: 1000/@ticksPerSecond
      @tickInterval: setInterval(@tick, @tickIntervalMs)
      @drawInterval: setInterval(@draw, 0)
  stop: =>
    if @tickInterval?
      clearInterval(@tickInterval)
      delete @tickInterval
      clearInterval(@drawInterval)
      delete @drawInterval
  tick: =>
    @gameTime += @tickIntervalMs
    for object in @objects
      object.tick()
    return # Don't save object.tick() return values
  draw: =>
    interpolation: (new Date().getTime() - @gameTime) / @tickIntervalMs
    interpolation: 1 if interpolation > 1
    if @context?
      @context.clearRect(0, 0, @context.canvas.width, @context.canvas.height)
      for object in @objects
        object.draw(@context, interpolation)
    return # Don't save object.draw() return values

class PlayObject
  tick: ->
  draw: ->

class Sprite extends PlayObject
  prevX: 0
  prevY: 0
  x: 0
  y: 0
  velocityX: 0
  velocityY: 0
  tick: ->
    @prevX: @x
    @prevY: @y
    @x += @velocityX
    @y += @velocityY
  draw: (context, interpolation) ->
    x: @x * interpolation + @prevX * (1-interpolation)
    y: @y * interpolation + @prevY * (1-interpolation)
    context.fillRect(x, y, 2, 2)

window.Playfield: Playfield
window.Sprite: Sprite
