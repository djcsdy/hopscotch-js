canvas: document.getElementsByTagName('canvas')[0]
playfield: new Playfield()
for i in [0...200]
  sprite: new Sprite()
  playfield.objects.push sprite
  sprite.x = canvas.width / 2
  sprite.y = canvas.height / 2
  angle: Math.random() * Math.PI * 2
  speed: Math.random() * 10
  sprite.velocityX = Math.sin(angle) * speed
  sprite.velocityY = Math.cos(angle) * speed
playfield.context: canvas.getContext('2d')
playfield.start()
