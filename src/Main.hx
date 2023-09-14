import haxe.Json;
import sys.io.File;

using StringTools;

class Main {
	static function main() {
		var args = Sys.args();

		switch (args[0]) {
			case "get":
				var f = File.getContent("/etc/config");
				if (args.length < 1) {
					Sys.println(f);
				} else {
					for (a in f.split("\n")) {
						if (a.contains(args[1])) {
							Sys.println(a);
						}
					}
				}
			case "init", "reset":
				var d = "";

				d += "version=1";
				d += "\npackages=";
				d += "\nxdg.default-web-browser=";

				File.saveContent("/etc/config", d);
			case "edit":
				Sys.command("sudo nano /etc/config");
			case "set":
				var f = File.getContent("/etc/config");
				for (a in f.split("\n")) {
					if (a.contains(args[1])) {
						f = f.replace(a, args[1] + "=" + args[2]);
					}
				}
				File.saveContent("/etc/config", f);
			case "install":
				var f = File.getContent(args[1]);
				File.saveContent("/etc/config", f);
		}
	}
}
