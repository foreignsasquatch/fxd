package fxd.ldtk;

import fxd.f2d.Global;

class Renderer {
  public static inline function drawTilemap(layer:ldtk.Layer_Tiles, tilesetTexture:Rl.Texture, tileset:ldtk.Tileset, sizeX:Int, sizeY:Int):Void {
    for(r in 0...layer.cHei) {
        for(c in 0...layer.cWid) {
            if(layer.hasAnyTileAt(c, r)) {
                var tileAtMapPos = layer.getTileStackAt(c, r);
                var tilesToDraw = tileAtMapPos[0];
                var x = c * sizeX;
                var y = r * sizeY;

                Rl.drawTexturePro(tilesetTexture, Rl.Rectangle.create(tileset.getAtlasX(tilesToDraw.tileId), tileset.getAtlasY(tilesToDraw.tileId), Global.tileSize, Global.tileSize), Rl.Rectangle.create(x, y, Global.tileSize, Global.tileSize), Rl.Vector2.zero(), 0, Rl.Colors.WHITE);
            }
        }
    }
  }
}