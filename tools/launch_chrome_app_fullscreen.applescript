# Launch Chrome App in Fullscreen
# Usage:
#    osascript ./launch_chrome_app_fullscreen.applescript "<My Chrome App[.app]>"

# run handler needed to read argv
on run argv
	set default_app to "Gravitational Waves"
	
	try
		set chrome_app to item 1 of argv
		if chrome_app ends with ".app" then
			set chrome_app to text 1 thru -5 of chrome_app
		end if
	on error
		set chrome_app to default_app
	end try
	
	# open app and wait for the window to show
	tell application chrome_app
		activate
		repeat until window 1 exists
			delay 0.5
		end repeat
	end tell
	
	tell application "System Events" to tell process chrome_app
		set frontmost to true
		
		# Uncheck "View / Always Show Toolbar in Full Screen" if checked
		set show_toolbar to (value of attribute "AXMenuItemMarkChar" of menu item "Always Show Toolbar in Full Screen" of menu 1 of menu bar item "View" of menu bar 1) is "✓"
		if show_toolbar then
			click menu item "Always Show Toolbar in Full Screen" of menu 1 of menu bar item "View" of menu bar 1
		end if
		
		# Enter Full Screen
		click menu item "Enter Full Screen" of menu 1 of menu bar item "View" of menu bar 1
	end tell
	
	return
end run
