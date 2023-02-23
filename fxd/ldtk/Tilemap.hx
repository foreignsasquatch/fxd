package fxd.ldtk;

import ldtk.Layer_Tiles;
import ldtk.Tileset;
import ldtk.Level;
import ldtk.Layer_Entities;

class Tilemap {
  public var tileset:Tileset;
  public var tilesetTexture:Rl.RlTexture;
  public var currentLevel:Level;
  public var tilemapLayers:Array<Layer_Tiles> = [];
  public var entities:Layer_Entities;

  public function new(world:{tileset:Tileset, tilesetTexture:Rl.RlTexture, currentLevel:Level, tilemapLayers:Array<Layer_Tiles>, entities:Layer_Entities}) {
    this.entities = world.entities;
    this.tileset = world.tileset;
    this.tilesetTexture = world.tilesetTexture;
    this.currentLevel = world.currentLevel;
    this.tilemapLayers = world.tilemapLayers;
  }

  public function getEntities(name:String):Array<EntityData> {
    var data:Array<EntityData> = [];

    for(e in entities.json.entityInstances) {
      if(e.__identifier == name) {
        data.push(new EntityData(e.px[0], e.px[1]));
      }
    }

    return data;
  }

  public function getEntityData(name:String, i:Int):EntityData {
    var data:EntityData = new EntityData(0, 0);

    for(e in entities.json.entityInstances) {
      if(e.__identifier == name) {
        data = new EntityData(e.px[0], e.px[1]);
      }
    }

    return data;
  }
}