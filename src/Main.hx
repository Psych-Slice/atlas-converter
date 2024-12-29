import formats.AtlasAnimFile;
import formats.AtlasSpritemap;
import formats.CsvAnimData;
import utill.Matrix;
import sys.FileSystem;
import atlasObjects.AtlasAnims.AnimationManifest;
import atlasObjects.SpriteMap.MetaResolution;
import sys.io.FileInput;
import haxe.io.Input;
import format.png.Reader;
import format.png.Tools;
import haxe.io.Path;
import formats.Sparrow;
import sys.io.File;

using StringTools;

class Main {
	static function main() {
		
		//? USER ARGS
		#if interp
		var path = "/home/mikolka/Desktop/pslice-atlas/playground/bfPixel.xml";//args[0];
		#else
		var args = Sys.args();
		if(args.length==0){
			trace("Missing path to .xml data file!");
			return;
		}
		var path = Sys.args()[0];
		#end
		//LOAD PATHS
		var folderName = Path.withoutExtension(path);
		var imageFilePath = folderName+".png";

		//Load METADATA
		if(!FileSystem.exists(folderName+".csv")){
			File.saveContent(folderName+".csv",CsvAnimData.TEMPLATE);
			trace("Created new csv file. Please define anims and run the command again!");
			return;
		}
		var csv = new CsvAnimData(File.getContent(folderName+".csv"));

		// PARSE SPARROW
		trace(folderName);
		var sparrow = new Sparrow(File.getContent(path));

		// MAKE ATLAS
		var spritemap = new AtlasSpritemap(sparrow,getImageSize(imageFilePath));
		//? These two are GLOBAl offsets
		var animations = new AtlasAnimFile(makeAnimManifests(csv.anims,sparrow.indices),Matrix.fromCsv(csv.global));

		deleteDirRecursively(folderName);
		FileSystem.createDirectory(folderName);
		File.saveContent(folderName+"/Animation.json",animations.makeJson());
		File.saveContent(folderName+"/spritemap1.json",spritemap.makeJson());
		File.copy(imageFilePath,folderName+"/spritemap1.png");
		trace("Done!!!");
		return;
	}
	static function makeAnimManifests(prefixes:Array<CsvLine>,indices:Array<SparrowFrame>):Array<AnimationManifest> {
		var result = new Array<AnimationManifest>();
		for (entry in prefixes){
			result.push({
				prefix: entry.animName,
				matrix: Matrix.fromCsv(entry),
				frames: indices.filter(s -> s.name.startsWith(entry.prefix))
			});
		}
		return result;
	}
	static function getImageSize(path:String):MetaResolution {
		var img_data = new Reader(File.read(path)).read();
		var hdr = Tools.getHeader(img_data);
		return{
			w: hdr.width,
			h: hdr.height
		};
	}
	private static function deleteDirRecursively(path:String) : Void
		{
		  if (sys.FileSystem.exists(path) && sys.FileSystem.isDirectory(path))
		  {
			var entries = sys.FileSystem.readDirectory(path);
			for (entry in entries) {
			  if (sys.FileSystem.isDirectory(path + '/' + entry)) {
				deleteDirRecursively(path + '/' + entry);
				sys.FileSystem.deleteDirectory(path + '/' + entry);
			  } else {
				sys.FileSystem.deleteFile(path + '/' + entry);
			  }
			}
		  }
		}
}
