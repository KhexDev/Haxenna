import flixel.FlxG;
import flixel.text.FlxText;

class Option
{
	static public var scrollSpeed:Float = 1;

	static public var canSync:Bool = true;

	static public var songName:String = "";

	static public var renderDistance:Float = 1;

	static public var downScroll:Bool = false;

	public static var controls:Array<String> = ["D", "F", "J", "K"];

	public static var controls2:Array<String> = ["NUMPADFOUR", "NUMPADFIVE", "NUMPADEIGHT", "NUMPADFSIX"];

	public static var players:Float = 1;

	public static var fps:Float = 120;

	public static var opponent:Bool = false;

	public static var middleScroll:Bool = false;

	public static var ghostTapping:Bool = false;

	public static var missSound:Bool = true;

	public static var offset:Float = 0;

	public static var multiplier:Float = 1;

	public static var input:Int = 0;

	public static var botPlay:Bool = false;

	public static var optimisation:Bool = true;

	public static var twoPlayer:Bool = false;

	var daOption:FlxText;
}

class ShitControl
{
	// static public var controls:Array<Bool> = ["D", "F", "J", "K"];
}
