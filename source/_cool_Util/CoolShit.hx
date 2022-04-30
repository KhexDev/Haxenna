package _cool_Util;

class CoolShit
{
	static public function moyenne(shitArray:Array<Float>)
	{
		var shitInt:Float = 0;

		for (i in 0...shitArray.length)
			shitInt += shitArray[i];

		return shitInt / shitArray.length;
	}
}
