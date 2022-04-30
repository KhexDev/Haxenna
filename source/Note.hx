import Options.Option;
import _cool_Util.Paths;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class Note extends FlxSprite
{
	var inCharter:Bool;

	public var wasHit:Bool;
	public var canBeHit:Bool;
	public var strumTime:Float;

	public var isSus:Bool;
	public var susLength:Float;
	public var isTail:Bool;

	public var ogLengthSus:Float;

	public var isLift:Bool;

	public var danger:Bool;

	public var tooLate:Bool;

	static public var hitZone:Array<Float> = [500, 130];

	public var noteData:Int;
	public var noteType:String;

	public var children:Array<Note>;
	public var isChildren:Bool;

	public var parent:Note;

	public var prevNote:Note;

	public var mustPress:Bool;

	public var isDuplicate:Bool = false;

	var data = ["LEFT", "LEFT", "UP", "RIGHT"];
	var dataColor = ['purple', 'blue', 'green', 'red'];

	public function new(x:Float, strumTime:Float = 0.0, noteData:Int = 0, noteType:String = 'normal', inCharter:Bool = false, isSus:Bool = false,
			isTail:Bool = false, isLift:Bool = false)
	{
		super(x, y);
		this.noteData = noteData;
		this.noteType = noteType;
		this.inCharter = inCharter;
		this.isSus = isSus;
		this.isTail = isTail;
		this.isLift = isLift;
		this.strumTime = strumTime;

		ogLengthSus = susLength;

		var shitStrum:Float;
		var shitNoteData:Int;

		children = [];

		// noteType = "danger";

		frames = Paths.getSparrowAtlas('$noteType/Arrows');

		if (inCharter)
			setGraphicSize(Std.int(width * 0.5));
		else
			setGraphicSize(Std.int(width * 0.7));

		if (this.noteType == "entity")
		{
			for (i in 0...4)
			{
				animation.addByPrefix(dataColor[i], dataColor[i], 1, false);
				animation.addByPrefix(dataColor[i] + ' hold', dataColor[i] + ' hold', 1, false);
				animation.addByPrefix(dataColor[i] + ' tail', dataColor[i] + ' tail', 1, false);
			}

			// this.x -= 270;
		}
		else if (this.noteType == "danger")
		{
			for (i in 0...4)
			{
				animation.addByPrefix(dataColor[i], dataColor[i] + "fire", 24, false);
			}
		}
		else
		{
			for (i in 0...4)
			{
				animation.addByPrefix(dataColor[i], dataColor[i] + " alone", 1, false);
				animation.addByPrefix(dataColor[i] + ' hold', dataColor[i] + ' hold', 1, false);
				animation.addByPrefix(dataColor[i] + ' tail', dataColor[i] + ' tail', 1, false);
			}

			this.x -= 80;
		}

		var _dataColor:Array<String> = ["purple", "blue", "green", "red"];

		var stepHeight = (((0.45 * Conductor.stepCrochet)) * FlxMath.roundDecimal(Option.scrollSpeed == 1 ? PlayState.speed : Option.scrollSpeed, 2));

		if (prevNote != null)
		{
			if (prevNote.isSus)
			{
				prevNote.scale.y = stepHeight / prevNote.height;
				prevNote.updateHitbox();
			}
		}

		// im proud of this function
		function getNoteType(type:String = "default"):String
		{
			if (type == "default")
				return _dataColor[this.noteData];
			return _dataColor[this.noteData] + " " + type;
		}

		if (this.isTail)
		{
			animation.play(getNoteType("tail"));
		}

		if (this.isSus)
		{
			animation.play(getNoteType("hold"));
		}
		else
		{
			animation.play(getNoteType());
		}

		if (this.noteType == "danger")
			this.x -= 320;
	}

	override public function update(elapsed:Float)
	{
		if (!inCharter)
			canBeHit = (strumTime <= Conductor.songPosition + (Conductor.safeFrames * 10)
				&& strumTime >= Conductor.songPosition - (Conductor.safeFrames * 10));

		// active = (Conductor.songPosition - strumTime < 1000 && !mustPress && !isSus);

		super.update(elapsed);
	}
}
