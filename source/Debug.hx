package;

import Sys;
import lime.app.Application;

class Debug
{
	static public function stop(str:String = "")
	{
		Application.current.window.alert();
		// Sys.exit(1);
	}
}
