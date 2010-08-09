interpolate = (a, b, mu) ->
  if a is undefined
    if mu >= 1 then b
    else undefined
  else if b is undefined
    if mu <= 0 then a
    else undefined
  else a*(1-mu) + b*mu

playfield = () ->
  gameTime = undefined
  context = undefined
  sprites = []
  updateInterval = undefined
  updateIntervalMs = 10
  update = ->
    updateTime = new Date().getTime()
    while (gameTime + updateIntervalMs) < updateTime
      gameTime = gameTime + updateIntervalMs
      sprite.tick() for sprite in sprites
    if context?
      mu = (updateTime - gameTime) / updateIntervalMs
      context.clearRect(0, 0, context.canvas.width, context.canvas.height)
      sprite.paint(context, mu) for sprite in sprites
    return
  return thisPlayfield =
    context: (context2) ->
      context = context2
      return thisPlayfield
    ticksPerSecond: (ticksPerSecond) ->
      updateIntervalMs = 1000/ticksPerSecond
      return thisPlayfield
    start: ->
      unless updateInterval?
        gameTime = new Date().getTime()
        updateInterval = setInterval(update, updateIntervalMs)
      return thisPlayfield
    stop: ->
      if tickInterval?
        clearInterval(tickInterval)
        tickInterval = undefined
      return thisPlayfield
    sprite: ->
      prevX = undefined
      prevY = undefined
      x = undefined
      y = undefined
      velocityX = 0
      velocityY = 0
      accelerationX = 0
      accelerationY = 0
      actor = undefined
      painter = undefined
      thisSprite =
        tick: ->
          prevX = x
          prevY = y
          x = x + velocityX
          y = y + velocityY
          velocityX = velocityX + accelerationX
          velocityY = velocityY + accelerationY
          if actor? then actor()
          return thisSprite
        actor: (actor2) ->
          actor = actor2
          return thisSprite
        paint: (context, mu) ->
          if (painter?) then painter(context,
              interpolate(prevX, x, mu), 
              interpolate(prevY, y, mu))
          return thisSprite
        painter: (painter2) ->
          painter = painter2
          return thisSprite
        move: (x2, y2) ->
          x = x2
          y = y2
          return thisSprite
        position: (x2, y2) ->
          x = x2
          y = y2
          prevX = undefined
          prevY = undefined
          return thisSprite
        velocity: (velocityX2, velocityY2) ->
          velocityX = velocityX2
          velocityY = velocityY2
          return thisSprite
        acceleration: (accelerationX2, accelerationY2) ->
          accelerationX = accelerationX2
          accelerationY = accelerationY2
          return thisSprite
      sprites.push(thisSprite)
      return thisSprite

imagePainter = (uri) ->
  image = new Image();
  image.src = uri
  compositeOperation = "source-over"
  alpha = 1
  thisPainter = (context, x, y) ->
    context.save()
    context.globalCompositeOperation = compositeOperation
    context.globalAlpha = alpha
    context.drawImage(image, x, y)
    context.restore()
    return thisPainter
  thisPainter.compositeOperation = (compositeOperation2) ->
    compositeOperation = compositeOperation2
    return thisPainter
  thisPainter.alpha = (alpha2) ->
    alpha = alpha2
    return thisPainter
  return thisPainter

window.hs =
  playfield: playfield
  imagePainter: imagePainter
