package fxd.assets;

class Aseprite {
  public static function loadTexture(file:String):Rl.Texture {
    var aseBytes = sys.io.File.getBytes(file);
    var ase:ase.Ase = ase.Ase.fromBytes(aseBytes);
    var layerIndex:Int = 0;
    var frame = ase.frames[0];
    var celWidth:Int = frame.cel(layerIndex).width;
    var celHeight:Int = frame.cel(layerIndex).height;
    var celPixelData:haxe.io.Bytes = frame.cel(layerIndex).pixelData;
    var celDataPointer:cpp.Pointer<cpp.Void> = cpp.NativeArray.address(celPixelData.getData(), 0).reinterpret();
    var celImage = Rl.Image.create(celDataPointer.raw, celWidth, celHeight, 1, Rl.PixelFormat.UNCOMPRESSED_R8G8B8A8);
    var celTexture = Rl.loadTextureFromImage(celImage); 
    return celTexture; 
  }
}
