package formats;

class CsvAnimData {
    public static final TEMPLATE:String = 
        "Animation name,Prefix,Offset X,Offset Y,Scale X,Scale Y\n"+
        "GLOBAL,global,0,0,1,1";
    public function new(csvData:String) {
        var lines = csvData.split('\n');
        lines.remove("");
        
        global = parseLine(lines[1]);

        for (i in 2...lines.length){
            anims.push(parseLine(lines[i]));
        }
    }
    private function parseLine(line:String):CsvLine {
        var seg = line.split(",");
        return{
            animName: seg[0],
            prefix: seg[1],
            offsetX: Std.parseFloat(seg[2]),
            offsetY: Std.parseFloat(seg[3]),
            scaleX: Std.parseFloat(seg[4]),
            scaleY: Std.parseFloat(seg[5])
        };
    }
    public var global:CsvLine;
    public var anims:Array<CsvLine> = new Array<CsvLine>();
}
typedef CsvLine = {
    var animName:String;
    var prefix:String;
    var offsetX:Float;
    var offsetY:Float;
    var scaleX:Float;
    var scaleY:Float;
}