package atlasObjects;

import utill.Matrix;
import utill.OneOfTwo;

typedef Symbol = {
    var SN:String; // Da name!
    var TL:Timeline;
}
class SymbolInstance {
    var SN:String;
    var FF:Int;
    var ST:String = "G"; // it's always graphic!
    var IN:String = "";
    var LP:String = "PO"; // Play Only, LooP or Single Frame
    var TRP:Dynamic = { // The center of the sprite for transform (I think)
        "x": 0.0,
        "y": 0.0
    };
    var M3D:Array<Float>;

    public function new(symbolName:String,frame:Int,matrix:Matrix) {
        SN = symbolName;
        FF = frame;
        M3D = matrix.matrix;
    }
}
typedef Timeline = {
    var L:Array<Layer>;
}
typedef Layer = {
    var LN:String; //Layer name
    var FR:Array<OneOfTwo<Frame,Label>>; // key frames
}

class Label{
    var N:String; // The Label name
    var I:Int;
    var DU:Int;
    var E:Array<Dynamic> = [];
    public function new(name:String,frameIndex:Int,duration:Int) {
        N = name;
        I = frameIndex;
        DU = duration;
    }
}
class Frame {
    var I:Int;
    var DU:Int;
    var E:Array<Element> = new Array<Element>();
    public function new(indiceName:String,frameIndex:Int,duration:Int,matrix:Matrix) {
        I = frameIndex;
        DU = duration;
        E.push({
            ASI: {
                M3D: matrix.matrix,
                N: indiceName
            }
        });
    }
}
typedef Element = {
    var ASI:IndiceRef;
}
typedef IndiceRef = {
    var M3D:Array<Float>;
    var N:String;
}