canvas = document.getElementsByTagName('canvas')[0]
playfield = hs.playfield().
    context(canvas.getContext('2d')).
    updatesPerSecond(100)

movingLeft = false
movingRight = false
movingUp = false
movingDown = false

sprite = playfield.sprite().
    painter(hs.imagePainter('grin.png')).
    position(canvas.width/2, canvas.height/2).
    actor(->
        vx = vy = 0
        if movingLeft then vx = -1
        if movingRight then vx = vx + 1
        if movingUp then vy = -1
        if movingDown then vy = vy + 1
        sprite.velocity(vx, vy))

onKeydown = (event) ->
  if event.keyIdentifier is 'Left' then movingLeft = true
  else if event.keyIdentifier is 'Right' then movingRight = true
  else if event.keyIdentifier is 'Up' then movingUp = true
  else if event.keyIdentifier is 'Down' then movingDown = true
document.body.addEventListener('keydown', onKeydown, true)

onKeyup = (event) ->
  if event.keyIdentifier is 'Left' then movingLeft = false
  else if event.keyIdentifier is 'Right' then movingRight = false
  else if event.keyIdentifier is 'Up' then movingUp = false
  else if event.keyIdentifier is 'Down' then movingDown = false
document.body.addEventListener('keyup', onKeyup, true)

playfield.start()
