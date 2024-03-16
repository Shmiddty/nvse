@:expose
class Hx {
  static function main() {}
  public static function Serialize(v:Dynamic) {
    return haxe.Serializer.run(v);
  }
  public static function Unserialize(v:String):Dynamic {
    return haxe.Unserializer.run(v);
  }
}
