package atlasObjects;

typedef AtlasFile = {
    var ATLAS:Atlas;
    var meta:Meta;
}
typedef Atlas = {
    var SPRITES:Array<SpriteItem>;
}
typedef SpriteItem = {
    var SPRITE:Sprite;
}
typedef Sprite = {
    var x:Int;
    var y:Int;

    var w:Int;
    var h:Int;

    var rotated:Bool;
    var name:String; // That's an indice, like "0000", "0001"
}
typedef Meta = {
    var app:String;
    var version:String;
    var image:String;
    var format:String;
    var size:MetaResolution;
    var resolution:String;
}
typedef MetaResolution = {
    var w:Int;
    var h:Int;
}