package fxd;

import fxd.f2d.Global;
import fxd.f2d.Layers;

@:allow(fxd.Application)
class State {
  public var layer:Layers = new Layers();

  public function new() {}

  public function preInit() {}
  public function onInit() {}
  public function onUpdate() {}
  public function postUpdate() {}
  public function onDestroy() {}

  function draw() {
    Rl.beginMode2D(Global.camera);
    for(l in layer.layers) {
      l.render();
    }
    Rl.endMode2D();
  }
}