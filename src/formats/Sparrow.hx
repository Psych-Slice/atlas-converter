package formats;

class Sparrow {
	var manifest:Xml;
	public var imagePath:String;
    public var indices:Array<SparrowFrame> = new Array<SparrowFrame>();
    public function new(xmlText:String) {
        var node = Xml.parse(xmlText);
        manifest = node.firstElement();
        imagePath = manifest.get("imagePath");
        for(frame in manifest.elementsNamed("SubTexture")){
            indices.push({
                name: frame.get("name"),
                x: frame.get("x"),
                y: frame.get("y"),
                width: frame.get("width"),
                height: frame.get("height"),
                frameY: frame.get("frameY"),
                frameX: frame.get("frameX"),
                frameHeight: frame.get("frameHeight"),
                frameWidth: frame.get("frameWidth")
            });
        }
    }
}

typedef SparrowFrame = {
    var name:String;

    var x:String;
    var y:String;
    var width:String;
    var height:String;

    var frameX:String;
    var frameY:String;
    var frameWidth:String;
    var frameHeight:String;
}