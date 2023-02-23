package fxd.f2d;

import fxd.ldtk.Marker;

class Entity {
  public var cx:Int;
  public var cy:Int;

  public var xr:Float;
  public var yr:Float;

  public var dx:Float;
  public var dy:Float;

  public var frx:Float = 0.98;
  public var fry:Float = 0.98;

  public var xx:Float;
  public var yy:Float;

  public var radius:Float =  3;

  public var isColliding = false;
  public var isCollidingEn = false;
  public var isCollidingTop = false;
  public var isCollidingBottom = false;
  public var isCollidingLeft = false;
  public var isCollidingRight = false;

  public var texture:Rl.Texture;
  /* location in texture (grid) */
  public var tx:Int = 0;
  public var ty:Int = 0;

  public static var ALL:Array<Entity> = [];

  public function new() {
    setCoords(0, 0);
    ALL.push(this);
    onInit();
  }

  public function onInit() {}
  public function onUpdate() {}
  public function debugDraw() {}

  function draw() {
  }

  public function dispose() {
    ALL.remove(this);
  }

  public function setCoords(x:Float, y:Float) {
    xx = x;
    yy = y;
    cx = Std.int(x / Global.tileSize);
    cy = Std.int(y / Global.tileSize);
    xr = (x - cx * Global.tileSize) / Global.tileSize;
    yr = (y - cy * Global.tileSize) / Global.tileSize;
  }

  public function updatePhysics() {
    xr += dx;
    dx *= frx;

    if(Global.collisionMarker != null) {
      if(Global.collisionMarker.check(cx + 1, cy) && xr >= 0) {
        xr = 0;
        dx = 0;
        isColliding = true;
      } else {
        isColliding = false;
      }

      if(Global.collisionMarker.check(cx - 1, cy) && xr <= 0) {
        xr = 0;
        dx = 0;
        isColliding = true;
      } else {
        isColliding = false;
      }
    }

    while(xr > 1) {
      xr--; cx++;
    }
    while(xr < 0) {
      xr++; cx--;
    }

    yr += dy;
    dy *= fry;

    // Top
    if(Global.collisionMarker != null) {
      if(Global.collisionMarker.check(cx, cy - 1) && yr <= 0) {
        yr = 0;
        dy = 0;
        isColliding = true;
        isCollidingTop = true;
      } else {
        isColliding = false;
        isCollidingTop = false;
      }

      // Bottom
      if(Global.collisionMarker.check(cx, cy + 1) && yr >= 0) {
        yr = 0;
        dy = 0;
        isColliding = true;
        isCollidingBottom = true;
      } else {
        isColliding = false;
        isCollidingBottom = false;
      }
    }

    while(yr > 1) {
      yr--;cy++;
    }
    while(yr < 0) {
      yr++;cy--;
    }

    xx = (cx + xr) * Global.tileSize;
    yy = (cy + yr) * Global.tileSize;
  }

  public function resolveCollision() {
    for(e in ALL) {
      if(e != this && Math.abs(cx - e.cx) <= 2  && Math.abs(cy - e.cy) <= 2) {
        var dist = Math.sqrt((e.xx - xx) * (e.xx - xx) + (e.yy - yy) * (e.yy - yy));
        if(dist <= radius + e.radius) {
          var ang = Math.atan2(e.yy - yy, e.xx - xx);
          var force = 0.2;
          var repelPower = (radius + e.radius - dist) / (radius + e.radius);
          dx -= Math.cos(ang) * repelPower * force;
          dy -= Math.sin(ang) * repelPower * force;
          e.dx += Math.cos(ang) * repelPower * force;
          e.dy += Math.sin(ang) * repelPower * force;
          isCollidingEn = true;
        } else {
          isCollidingEn = false;
        }
      }
    }
  }

  public inline function overlapsEntity(e:Entity):Bool {
    var maxDist = radius + e.radius;
    var distSqr = (e.xx - xx) * (e.xx - xx) + (e.yy - yy) * (e.yy - yy);
    return distSqr <= maxDist * maxDist;
  }
}