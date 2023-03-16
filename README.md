## autostart-mac

launchd (Launch Agent/Service) Installer Script  
Developed on macOS 13.2

* The script is called `autostart`
* On install, it symnlinks itself to `/usr/local/bin/` so it is in the path
* On login, it launches the script called `start.sh` and keeps it running

Command line options:

* `install`: Installs the script into the path, installs the launch agent, and starts it.
* `uninstall`|`remove`: Stops the launch agent, removes it and removes the script from the path.
* `enable`, `disable`: A disabled launch agent doesn't start at login. Disabling doesn't stop the launched process.
* `start`, `stop`: Start or stop the associated process. Launch agent needs to be enabled in order to be started.
* `status`: Show status info. Error if stopped.
