import flixel.group.FlxGroup.FlxTypedGroup;

enum INPUT
{
	KADE;
	PSYCH;
	FUNKIN;
	HAXENNA;
}

class Inputs
{
	public var hitNotes:Array<Note> = [];

	public static var dumbNotes:Array<Note> = [];

	// from kade input
	public static var dataAccounted:Array<Bool> = [false, false, false, false];

	static public function processInput(input:INPUT, notes:FlxTypedGroup<Note>, keys:Array<Bool>, player:Int = 1):Array<Note>
	{
		dumbNotes = [];

		switch (input)
		{
			case KADE:
				{
					// trace("doing shit from kade");

					var possibleNotes:Array<Note> = [];
					// var dataAccounted:Array<Bool> = [];
					dataAccounted = [false, false, false, false];
					var dataList:Array<Int> = [];
					var noteDatas:Array<Note> = [];

					notes.forEachAlive(function(note:Note)
					{
						if (note.canBeHit && note.mustPress && !note.isSus)
						{
							noteDatas.push(note);
						}

						if (note.canBeHit && note.mustPress && !note.isSus && !dataAccounted[note.noteData])
						{
							if (dataList.contains(note.noteData))
							{
								dataAccounted[note.noteData] = true;

								for (coolNote in possibleNotes)
								{
									if (coolNote.noteData == note.noteData && coolNote.strumTime - coolNote.strumTime < 10)
									{
										trace("found duplicate");
										dumbNotes.push(note);
										break;
									}
									else if (coolNote.strumTime > note.strumTime)
									{
										trace("replacing note order");
										break;
									}
								}
							}
							else
							{
								possibleNotes.push(note);
								dataAccounted[note.noteData] = true;
								dataList.push(note.noteData);
							}
						}
					});

					// before sending data, we check for duplicate notes to remove
					/*for (note in noteDatas)
						{
							if (note.noteData == note.prevNote.noteData
								&& Math.abs(note.strumTime - note.prevNote.strumTime) < 10
								&& !note.prevNote.isSus)
							{
								trace("we found a dumb one");
								dumbNotes.push(note);

								if (possibleNotes.contains(note))
								{
									trace("removing some duplicate notes");
									possibleNotes.remove(note);
								}
							}
					}*/

					return possibleNotes;
				}
			case FUNKIN:
				{
					trace("doing shit from funkin");

					var possibleNotes:Array<Note> = [];
					var hitNotes:Array<Note> = [];
					var ignoreList:Array<Int> = [];

					notes.forEachAlive(function(note:Note)
					{
						if (note.canBeHit && !note.isSus && note.mustPress && !ignoreList.contains(note.noteData))
						{
							ignoreList.push(note.noteData);
							possibleNotes.push(note);
						}
					});

					if (possibleNotes.length > 0)
					{
						var daNote = possibleNotes[0];

						if (keys[daNote.noteData])
						{
							hitNotes.push(daNote);
						}

						if (possibleNotes.length > 2)
						{
							for (note in possibleNotes)
							{
								if (daNote != note)
								{
									if (note.noteData == daNote.noteData && Math.abs(daNote.noteData - note.noteData) < 10)
									{
										dumbNotes.push(note);
										possibleNotes.remove(note);
									}
									else if (keys[note.noteData])
									{
										hitNotes.push(note);
									}
								}
							}
						}

						return hitNotes;
					}
				}
			case PSYCH:
				{
					trace("doing shit from psych");
					// input code
				}
			case HAXENNA:
				{
					trace("doing haxe shit");
					// input code
				}
		}

		return null;
	}

	function checkHit():Note
	{
		return null;
	}
}
