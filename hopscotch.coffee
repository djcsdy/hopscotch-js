interpolate: (a, b, mu) ->
  if a is undefined
    if mu >= 1 then b
    else undefined
  else if b is undefined
    if mu <= 0 then a
    else undefined
  else a*(1-mu) + b*mu

playfield: () ->
  gameTime: undefined
  context: undefined
  sprites: []
  tickInterval: undefined
  tickIntervalMs: 10
  tick: ->
    gameTime: gameTime + tickIntervalMs
    for sprite in sprites
      sprite.tick()
    return
  paintInterval: undefined
  paint: ->
    mu: (new Date().getTime() - gameTime) / tickIntervalMs
    if context?
      context.clearRect(0, 0, context.canvas.width, context.canvas.height)
      for sprite in sprites
        sprite.paint(context, mu)
    return
  return thisPlayfield: {
    context: (context2) ->
      context: context2
      return thisPlayfield
    ticksPerSecond: (ticksPerSecond) ->
      tickIntervalMs: 1000/ticksPerSecond
      return thisPlayfield
    start: ->
      unless tickInterval?
        gameTime: new Date().getTime()
        tickInterval: setInterval(tick, tickIntervalMs)
        paintInterval: setInterval(paint, 0)
      return thisPlayfield
    stop: ->
      if tickInterval?
        clearInterval(tickInterval)
        tickInterval: undefined
        clearInterval(paintInterval)
        paintInterval: undefined
      return thisPlayfield
    sprite: ->
      prevX: undefined
      prevY: undefined
      x: undefined
      y: undefined
      velocityX: 0
      velocityY: 0
      actor: undefined
      painter: undefined
      thisSprite: {
        tick: ->
          prevX: x
          prevY: y
          x: x + velocityX
          y: y + velocityY
          actor?.act()
          return thisSprite
        actor: (actor2) ->
          actor: actor2
          return thisSprite
        paint: (context, mu) ->
          painter?.paint(context,
              interpolate(prevX, x, mu), 
              interpolate(prevY, y, mu))
          return thisSprite
        painter: (painter2) ->
          painter: painter2
          return thisSprite
        move: (x2, y2) ->
          x: x2
          y: y2
          return thisSprite
        position: (x2, y2) ->
          x: x2
          y: y2
          prevX: undefined
          prevY: undefined
          return thisSprite
        velocity: (velocityX2, velocityY2) ->
          velocityX: velocityX2
          velocityY: velocityY2
          return thisSprite
      }
      sprites.push(thisSprite)
      return thisSprite
  }

imagePainter: (uri) ->
  image: new Image();
  image.src: uri
  compositeOperation: "source-over"
  return thisPainter: {
    paint: (context, x, y) ->
      context.save()
      context.globalCompositeOperation: compositeOperation
      context.drawImage(image, x, y)
      context.restore()
      return thisPainter
    compositeOperation: (compositeOperation2) ->
      compositeOperation: compositeOperation2
      return thisPainter
  }

window.hs: {
  playfield: playfield
  imagePainter: imagePainter
}
