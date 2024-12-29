package atlasObjects;
import utill.Matrix;
import formats.Sparrow;
import atlasObjects.Symbols;


typedef AnimationManifest = {
    var prefix:String;
    var frames:Array<SparrowFrame>;
    var matrix:Matrix;
}

typedef AtlasMainSymbol = {
    var N:String; // It's the name from the FLA or so... 
    var STI:AnimStage;

    var TL:Timeline;
    var SN:String; // Symbol name. Do we need this???
}
typedef AnimStage = {
    var SI:SymbolInstance;
}
typedef AtlasSymbolDict = {
    var S:Array<Symbol>;
}
class AtlasMetadata{
    var FRT:Float;
    public function new(framerate:Float) {
        FRT = framerate;
    }
}