package fxd.ldtk;

import fxd.f2d.Entity;

class EntityData {
  public var xx:Int;
  public var yy:Int;

  public function new(x:Int, y:Int) {
    xx = x;
    yy = y;
  }

  public function to(e:Entity) {
    e.setCoords(xx, yy);
  }
}