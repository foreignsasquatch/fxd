package fxd.ldtk;

import ldtk.Tileset;
import ldtk.Layer_Tiles;

typedef Col = {
  x:Int,
  y:Int
}

class Marker {
  public var name:String;
  public var layer:Layer_Tiles;
  public var tileset:Tileset;

  public var collidable:Array<Int> = [];
  public var checkable:Array<Col> = [];

  public function new(n:String, t:Tileset, l:Layer_Tiles) {
    name = n;
    tileset = t;
    layer = l;

    for(e in tileset.json.enumTags) {
      if(e.enumValueId == name) {
        for(t in e.tileIds) {
          collidable.push(t);
        }
      }
    } 

    for(r in 0...layer.cHei) {
      for(c in 0...layer.cWid) {
        if(layer.hasAnyTileAt(c, r)) {
          var tile = layer.getTileStackAt(c, r)[0];
          for(co in collidable) {
            if(tile.tileId == co) {
              checkable.push({x: c, y: r});
            }
          }
        }
      }
    }
  }

  public function check(x:Int, y:Int):Bool {
    var col = false;
    for(c in checkable) {
      if(c.x == x && c.y == y) {
        col = true;
      }
    }
    return col;
  }
}