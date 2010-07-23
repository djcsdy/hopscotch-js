canvas: document.getElementsByTagName('canvas')[0]
x: canvas.width/2
y: canvas.height/2
playfield: hs.playfield().
    context(canvas.getContext('2d')).
    ticksPerSecond(100)
for i in [0...200]
  angle: Math.random() * Math.PI * 2
  speed: Math.random() * 10
  playfield.sprite().
      painter(hs.imagePainter('spark.png').
          compositeOperation('lighter')).
      position(x, y).
      velocity(Math.sin(angle) * speed, Math.cos(angle) * speed)
playfield.start()
