package fxd;

import fxd.f2d.Global;

class Application {
  public static var width:Int;
  public static var height:Int;
  public static var title:String;
  public static var currentState:State;

  static var timeCounter = 0.0;
  static var timeStep = 1 / 60;

  public static var shader:Rl.Shader;
  static var target:Rl.RenderTexture;

  public function new(width:Int, height:Int, title:String, state:State, targetFps:Int = 60) {
    Application.width = width;
    Application.height = height;
    Application.title = title;
    currentState = state;

  //  Rl.setTraceLogLevel(Rl.TraceLogLevel.ERROR);
    Rl.initWindow(Application.width, Application.height, Application.title);
    Rl.setTargetFPS(targetFps);

    target = Rl.loadRenderTexture(width, height);

    #if HXCPP_PROFILER
    Profiler.start("PROFILER_REPORT");
    #end

    Global.camera = Rl.Camera2D.create(Rl.Vector2.zero(), Rl.Vector2.zero());
    Global.bgColor = Rl.Colors.BLACK;

    state.preInit();
    state.onInit();

    while (!Rl.windowShouldClose()) {
      update();
    }

    state.onDestroy();
    Rl.closeWindow();

    #if HXCPP_PROFILER
    Profiler.stop();
    #end
  }

  static function update() {
    // Fixed step
    timeCounter += Rl.getFrameTime();
    while (timeCounter > timeStep) {
      currentState.onUpdate();
      currentState.postUpdate();
      timeCounter -= timeStep;
    }

    Rl.beginTextureMode(target);
    Rl.clearBackground(Global.bgColor);
    
    currentState.draw();
    Rl.endTextureMode();

    Rl.beginDrawing();
    {
      Rl.clearBackground(Global.bgColor);

      Rl.drawTextureRec(target.texture, Rl.Rectangle.create(0, 0, width, -height), Rl.Vector2.create( 0, 0 ), Rl.Colors.WHITE);
    }
    Rl.endDrawing();
  }

  public static function setCurrentState(s:State) {
    currentState.onDestroy();
    currentState = s;
  }
}
