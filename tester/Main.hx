import sys.FileSystem;
import haxe.io.Path;
import sys.io.File;

using StringTools;

class Main {
	static function main() {
		var path = Path.join([Sys.getCwd(), "Autobuild"]);
		if (Sys.args().length > 0)
			path = Sys.args()[0];
		if (!FileSystem.exists(path)) {
			Sys.println('Error: $path does not exist');
			Sys.exit(1);
		}
		var script = File.getContent(path);

		var exec_queue = new Array<String>();

		var config:Build = {
			name: null,
			test_command: null,
			collect_files: null,
			collect_dirs: null,
			arch: null,
			os: null,
			version: null
		};

		for (i in 0...script.split("\n").length) {
			var line = script.split("\n")[i];
			if (line.startsWith("#")) {
				var k = line.split(" ")[0].substr(1);
				var tv = line.split(" ");
				tv.shift();
				var v = tv.join(" ");

				switch (k) {
					case "name":
						config.name = v;
					case "version":
						config.version = v;
					case "os":
						config.os = v.split(",");
					case "arch":
						config.arch = v.split(",");
					case "collect_dirs":
						config.collect_dirs = v.split(",");
					case "collect_files":
						config.collect_files = v.split(",");
					case "test_command":
						config.test_command = v;
					default:
						Sys.println('Autobuild: line ${i + 1}: invalid definition: \'$k\'');
						Sys.exit(1);
				}
			} else if (line.length > 0) {
				exec_queue.push(line);
			}
		}

		for (command in exec_queue) {
			if (Sys.command(command) > 0) {
				Sys.println('Failed to build: failed to execute \'$command\'');
				Sys.exit(1);
			}
		}

		if (Sys.command(config.test_command) > 0) {
			Sys.println('Failed to test: failed to execute \'${config.test_command}\'');
			Sys.exit(1);
		}

		Sys.exit(0);
	}
}
