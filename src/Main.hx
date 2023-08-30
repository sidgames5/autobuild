import hscript.Interp;
import sys.io.File;
import hscript.Parser;

using StringTools;

class Main {
	static function main() {
		var script = File.getContent("examples/Autobuild");

		for (line in script.split("\n")) {
			if (line.startsWith("#")) {} else {
				Sys.command(line);
			}
		}
	}
}
