package formats;

import haxe.Json;
import atlasObjects.SpriteMap.SpriteItem;
import atlasObjects.SpriteMap.MetaResolution;
import atlasObjects.SpriteMap.Meta;
import atlasObjects.SpriteMap.AtlasFile;

class AtlasSpritemap {
    public var core:AtlasFile;
    public function new(sparrow:Sparrow,resolution:MetaResolution) {
        core = {
            meta: makeMeta(resolution),
            ATLAS: {
                SPRITES: pullIndices(sparrow)
            }
        };
    }
    public function makeJson():String {
        return Json.stringify(core,null,'\t');
    }
    private function makeMeta(resolution:MetaResolution):Meta {
        return {
            app: "P-Slice Converter",
            resolution: "1",
            format: "GBA8888",
            version: "1.0",
            image: "spritemap1.png",
            size: resolution
        };
    }
    private function pullIndices(sparrow:Sparrow):Array<SpriteItem> {
        var out = new Array<SpriteItem>();
        for(i in 0...sparrow.indices.length){
            var item = sparrow.indices[i];
            out.push({
                SPRITE: {
                    x: Std.parseInt(item.x),
                    y: Std.parseInt(item.y),
                    w: Std.parseInt(item.width),
                    h: Std.parseInt(item.height),
                    rotated: false,
                    name: item.name
                }
            });
        }
        return out;
    }
    private function makeIndiceName(index:Int):String {
        var base = Std.string(index);
        var out = "";
        while(out.length+base.length<4){
            out += "0";
        }
        return out+base;
    }
}