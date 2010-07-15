class Playfield
  ticksPerSecond: 100
  constructor: ->
    @objects: []
  start: =>
    unless @tickInterval?
      @tickInterval: setInterval(@tick, 1000/@ticksPerSecond)
      @drawInterval: setInterval(@draw, 0)
  stop: =>
    if @tickInterval?
      clearInterval(@tickInterval)
      delete @tickInterval
      clearInterval(@drawInterval)
      delete @drawInterval
  tick: =>
    for object in @objects
      object.tick()
    return # Don't save object.tick() return values
  draw: =>
    if @context?
      @context.clearRect(0, 0, @context.canvas.width, @context.canvas.height)
      for object in @objects
        object.draw(@context)
    return # Don't save object.draw() return values

class PlayObject
  tick: ->
  draw: ->

class Sprite extends PlayObject
  x: 0
  y: 0
  velocityX: 0
  velocityY: 0
  tick: ->
    @x += @velocityX
    @y += @velocityY
  draw: (context) ->
    context.fillRect(@x, @y, 2, 2)

window.Playfield: Playfield
window.Sprite: Sprite
