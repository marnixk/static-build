#!/usr/bin/env tclsh


lassign $argv baseFolder configFile

source $configFile

#
#	Replaces <!--include file="" --> with the actual contents and writes the output to the console
#

proc get-file-contents {filename} {
	global baseFolder

	set fp [open "$baseFolder/$filename" r]
	set contents ""
	while { ![eof $fp] } {
		gets $fp line
		append contents "[replace-statements $line]\n"
	}

	return $contents
}

#
#	Get the variable contents and place it there.
#
proc get-variable-contents {varName} {
	global variables
	foreach varPair $variables {
		lassign $varPair key value
		if {$varName == $key} {
			return $value
		}
	}

	return "unknown"
}


#
#	Replace the include statement
#
proc replace-statements {line} {
	set results [regexp -all -inline {<!--#(\w+) (\w+)="([^\"]+)"\s*-->} $line]
	set idxResults [regexp -indices -inline {<!--#(\w+) (\w+)="([^\"]+)"\s*-->} $line]

	if {[llength $results] != 4} then {
		return $line
	}

	lassign $results -> command attr value

	# make sure it's an include statements
	if {$command == "include"} then {
		lassign $idxResults wholeMatch
		set fileContents [get-file-contents $value]
		return [string replace $line {*}$wholeMatch $fileContents]
	}

	# replacing the variable result
	if {$command == "var" } then {
		lassign $idxResults wholeMatch
		set variableContents [get-variable-contents $value]
		return [string replace $line {*}$wholeMatch $variableContents]
	}

	return "($idxResults / $results): $line"
}


while { ![eof stdin] } {
	gets stdin line
	puts "[replace-statements $line]"
}
