package fxd.assets;

class Assets {
  public static var textures:Map<String, Rl.Texture> = [];
  public static var fonts:Map<String, Rl.Font> = [];

  public static function load(a:Array<String>) {
    for(v in a) {
      if(StringTools.contains(v, ".ase") || StringTools.contains(v, ".aseprite")) { 
        var n = v.split(".")[0];
        var na = n.split("/")[1];
        var t = Aseprite.loadTexture(v);
        textures.set(na, t);
      }

      if(StringTools.contains(v, ".ttf")) {
        var n = v.split(".")[0];
        var na = n.split("/")[1];
        var f = Rl.loadFont(v);
        fonts.set(na, f);
      }
    }
  }
}