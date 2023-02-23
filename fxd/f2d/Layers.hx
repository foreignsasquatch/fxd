package fxd.f2d;

import fxd.ldtk.Tilemap;
import fxd.ldtk.Renderer;
import ldtk.Layer_Tiles;

class Layer {
  public var entities:Array<Entity> = [];
  public var tilemap:Array<Layer_Tiles> = [];
  public var map:Tilemap;

  public function new(e:Array<Entity>, t:Array<Layer_Tiles>, m:Tilemap) {
    entities = e;
    tilemap = t;
    map = m;
  }

  public function render() {
    for(e in entities) {
      Rl.drawTextureRec(e.texture, Rl.Rectangle.create(e.tx * Global.tileSize, e.ty * Global.tileSize, Global.tileSize, Global.tileSize), Rl.Vector2.create(e.xx, e.yy), Rl.Colors.WHITE);
      //Rl.drawCircleV(Rl.Vector2.create(e.xx + 4, e.yy + 4), e.radius, Rl.Color.create(0, 255, 0, 100));
      e.debugDraw();
    }

    for(t in tilemap) {
      Renderer.drawTilemap(t, map.tilesetTexture, map.tileset, Global.tileSize, Global.tileSize);
    }
  }
}

class Layers {
  public var layers:Array<Layer> = [];
  public var layerId:Map<String, Layer> = [];

  public function new() {}

  public function addLayer(name:String, index:Int, map:Tilemap) {
    layers.insert(index, new Layer([], [], map));
    layerId.set(name, layers[index]);
  }

  public function addEntity(en:Entity, layer:String) {
    layerId.get(layer).entities.push(en);
  }

  public function addTilemapLayer(t:Layer_Tiles, layer:String) {
    layerId.get(layer).tilemap.push(t);
  }

  public function render() {
    for(l in layers) {
      l.render();
    }
  }
}
