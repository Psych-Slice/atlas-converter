package utill;

import formats.CsvAnimData.CsvLine;

class Matrix {
    public var matrix:Array<Float>;
    public function new(offsetX:Float = 0.0,offsetY:Float = 0.0,scaleX:Float = 1.0,scaleY:Float = 1.0) {
        matrix = [
            scaleX,0.0,0.0,0.0,
            0.0,scaleY,0.0,0.0,
            0.0,0.0,1.0,0.0,
            offsetX,offsetY,0.0,1.0
        ];
    }
    public static function fromCsv(csvLine:CsvLine):Matrix {
        return new Matrix(csvLine.offsetX,csvLine.offsetY,csvLine.scaleX,csvLine.scaleY);
    }
}