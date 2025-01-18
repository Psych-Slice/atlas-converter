package formats;

import utill.Matrix;
import atlasObjects.Symbols;
import atlasObjects.Symbols.Label;
import utill.OneOfTwo;
import haxe.Json;
import atlasObjects.AtlasAnims.AtlasMainSymbol;
import atlasObjects.AtlasAnims.AnimationManifest;
import atlasObjects.Symbols.SymbolInstance;
import atlasObjects.AtlasAnims.AtlasSymbolDict;
import atlasObjects.AtlasAnims.AtlasMetadata;

class AtlasAnimFile{
    var AN:AtlasMainSymbol;
    var MD:AtlasMetadata;
    var SD:AtlasSymbolDict;

    public function new(anims:Array<AnimationManifest>,matrix:Matrix) {
        MD = new AtlasMetadata(24);
        AN = {
            N: "Converted sprite",
            SN: "Main symbol",
            STI: {
                SI: new SymbolInstance("Main symbol",0,matrix)
            },
            TL: {
                L: [
                    makeAtlasSparrowLayer(anims),
                    makeLabelsLayer(anims)
                ]
            }
        }
        SD = {
            S: toSymbols(anims)
        }
    }
    public function makeJson():String {
        return Json.stringify(this);
    }
    private function makeAtlasSparrowLayer(anims:Array<AnimationManifest>):Layer {
        var frames = new Array<OneOfTwo<Frame,Label>>();
        var curFrame = 0;
        for (anim in anims){
            for (item in anim.frames){
                var final_matrix = anim.matrix;
                if(item.frameX != null){
                    // var frameDiff_x = Std.parseFloat(item.frameWidth)-Std.parseFloat(item.width);
                    // var frameDiff_y = Std.parseFloat(item.frameHeight)-Std.parseFloat(item.height);

                    var frameX =  anim.matrix.offsetX - (Std.parseFloat(item.frameX)*anim.matrix.scaleX);
                    var frameY = anim.matrix.offsetY - (Std.parseFloat(item.frameY)*anim.matrix.scaleY);
                    final_matrix = new Matrix(frameX,frameY,anim.matrix.scaleX,anim.matrix.scaleY);
                }
                frames.push(new Frame(item.name,curFrame,1,final_matrix));
                curFrame++;
            }
        }
        return {
            LN: "Sparrow_frames",
            FR: frames
        }
    }
    private function makeLabelsLayer(anims:Array<AnimationManifest>):Layer {
        var frames = new Array<OneOfTwo<Frame,Label>>();
        var curFrame = 0;
        for (anim in anims){
            var len = anim.frames.length;
            frames.push(new Label(anim.prefix,curFrame,len));
            curFrame += len;
        }
        return {
            LN: "Sparrow_labels",
            FR: frames
        }
    }
    private function toSymbols(anims:Array<AnimationManifest>) {
        var result = new Array<Symbol>();
        for (anim in anims){
            result.push({
                SN: "symbol_"+anim.prefix,
                TL: {
                    L: [
                        makeAtlasSparrowLayer([anim])
                    ]
                }
            });
        }
        return result;
    }
}