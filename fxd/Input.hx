package fxd;

typedef InputData = {
  actionMap:Map<String, Array<Int>>
}

class Input {
  public var saveFile:String;
  public var data:InputData;

  public function new(file:String) {
    saveFile = file;
    data = {actionMap: []};
  }

  public function addInput(name:String, keys:Array<Int>) {
    data.actionMap.set(name, keys);
  }

  public function removeInput(name:String) {
    data.actionMap.remove(name);
  }

  public function getInputDown(name:String):Bool {
    var b = false;
    var keys = data.actionMap.get(name);

    for(k in keys) {
      if(Rl.isKeyDown(k)) b = true;
    }

    return b;
  }

  public function getInputJustDown(name:String):Bool {
    var b = false;
    var keys = data.actionMap.get(name);

    for(k in keys) {
      if(Rl.isKeyPressed(k)) b = true;
    }

    return b;
  }

  public function save() {
    sys.io.File.saveContent(saveFile, haxe.Json.stringify(data, "\t"));
  }
}