package _cool_Util;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.events.KeyboardEvent;

using StringTools;

class SearchBar extends FlxTypedGroup<FlxSprite>
{
	var bg:FlxSprite;

	var daText:String = "";
	var inputText:FlxText;

	public var width:Float;
	public var height:Float;
	public var x:Float;
	public var y:Float;

	public var data:Array<String> = []; // data to compare

	var result:Array<String> = [];

	public var typing:Bool = false;

	public function new(x:Float = 0, y:Float = 0)
	{
		super();

		this.x = x;
		this.y = y;

		bg = new FlxSprite(this.x, this.y).makeGraphic(350, 25);
		bg.x -= (bg.width / 2);
		add(bg);

		width = bg.width;
		height = bg.height;
		this.x = bg.x;
		this.y = bg.y;

		inputText = new FlxText(bg.x + 5, bg.y + 2, 0, "search...", 16);
		inputText.color = FlxColor.GRAY;
		add(inputText);

		for (sprite in members)
		{
			sprite.scrollFactor.set();
		}

		FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, typingCallback);
	}

	function typingCallback(event:KeyboardEvent)
	{
		if (typing)
		{
			try
			{
				var converted = FlxKey.toStringMap.get(event.keyCode);
				var tempText:Array<String>;
				trace(converted + " -> " + event.keyCode);

				switch (converted)
				{
					case "SPACE":
						{
							daText += " ";
						}
					case "BACKSPACE":
						{
							tempText = daText.split(daText.charAt(daText.length));
							daText = "";
							for (i in 0...tempText.length - 1)
							{
								daText += tempText[i];
							}
							updateText();
						}
					case "CONTROL":
						{
							return;
						}
					default:
						daText += converted.toString().toLowerCase();

						updateText();
				}
			}
			catch (e)
			{
				#if debug
				trace(e);
				#end
			}
		}
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.mouse.justPressed)
		{
			if (FlxG.mouse.overlaps(bg))
			{
				if (typing)
				{
					return;
				}
				else
				{
					inputText.text = "";
					typing = true;
					trace("typing...");
					updateText();
				}
			}
			else
			{
				if (!typing)
				{
					return;
				}
				else
				{
					if (inputText.text == "")
					{
						inputText.text = "search...";
					}
					typing = false;
					trace("not typing anymore...");
					updateText();
				}
			}
		}

		if (FlxG.keys.justPressed.ENTER)
		{
			if (typing)
			{
				typing = false;
			}
		}

		super.update(elapsed);
	}

	function updateText()
	{
		remove(inputText);

		if (daText == "" || daText == null)
		{
			inputText.text = "";
		}
		else
		{
			inputText.text = daText;
		}

		add(inputText);
	}

	public function getResult():Array<String>
	{
		result = [];

		for (text in data)
		{
			for (i in 0...text.length)
			{
				if (text.charAt(i) == daText.charAt(i))
				{
					trace(text);
					result.push(text);
					break;
				}
			}
		}

		// if (typing)
		// {
		// 	typing = false;
		// }

		return result;
	}

	public function changeSize(width:Float = 0, height:Float = 0) {}
}
