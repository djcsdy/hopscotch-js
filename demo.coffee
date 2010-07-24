canvas: document.getElementsByTagName('canvas')[0]
x: canvas.width/2
y: canvas.height/2
playfield: hs.playfield().
    context(canvas.getContext('2d')).
    ticksPerSecond(100)
for i in [0...200]
  angle: Math.random() * Math.PI * 2
  speed: Math.random() * 10
  vx: Math.sin(angle) * speed
  vy: Math.cos(angle) * speed
  gravity: Math.random() * 0.3 + 0.05
  fadeRate: Math.random() * 0.07 + 0.01
  alpha: 1
  painter: hs.imagePainter('spark.png').
      compositeOperation('lighter')
  sprite: playfield.sprite().
      painter(painter).
      position(x, y).
      velocity(vx, vy).
      acceleration(0, gravity).
      actor(() ->
          alpha: alpha - fadeRate
          if alpha < 0 then alpha: 0
          painter.alpha(alpha))
playfield.start()
