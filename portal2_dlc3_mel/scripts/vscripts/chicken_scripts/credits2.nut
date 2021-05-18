// ====================================================
// = CUSTOM CREDITS MADE BY CHICKENMOBILE
// = INSTANCE TO USE IS CHICKEN_INSTANCES/CREDITS.VMF. 
// = To start the credits -> 'Trigger' @DisplayCredits through the instance
// ====================================================
DBG <- 0 //Turns debug statements on or off

// This holds all the lines for the credits. New lines within each game_text are added using \n
// 'Hold' is how long the text stays on the screen after the text has faded in
// 'Delay' is how long it stays black before the wanted text appears
// 'reversed' will swap the default position of the title with the subtitle
// 'position' manually sets the position of the title. I suggest you don't put 'reversed' and 'position' together
CREDITS <- [
	{ title_text = "From the Development Team", subtitle_text = "Happy Holidays", reversed = true, delay = 2, hold = 5 },
	{ title_text = "Project Lead:", subtitle_text = "Tmast98", delay = 2, hold = 4 },
	{ title_text = "Level Design:", subtitle_text = "DaMaGepy\njosepezdj\nP0rtalPlayer\nTmast98", position = 0.2, delay = 2, hold = 5 },
	{ title_text = "Texture Artists/Modelers:", subtitle_text = "Colossal\njosepezdj", position = 0.2, delay = 2, hold = 5 },
	{ title_text = "Music:", subtitle_text = "GLaDos Cube\nvanSulli", position = 0.2, delay = 2, hold = 5 },
	{ title_text = "Special Thanks To:", subtitle_text = "Caden\nCamben\nChickenMobile\nDeathWish808", position = 0.2, delay = 2, hold = 5 },
	{ title_text = "Special Thanks To:", subtitle_text = "Deli73\nFalling Darkness\nHCMonsterLP\niviv", position = 0.2, delay = 2, hold = 5 },
	{ title_text = "Special Thanks To:", subtitle_text = "iWork925\nl1zardr0ckets\nLoneWolf2056\nlpfreaky90", position = 0.2, delay = 2, hold = 5 },
	{ title_text = "Special Thanks To:", subtitle_text = "Mevious\nRADELITE\nSpicy Dragon\nSpyrunite\n", position = 0.2, delay = 2, hold = 5 },
	{ title_text = "Special Thanks To:", subtitle_text = "Squeebat\nUniversity Of Miami Orchestra\nValveSoftware", position = 0.2, delay = 2, hold = 5 },
	{ title_text = "THANK YOU FOR PLAYING", subtitle_text = "Press Space to Exit the Map", delay = 2, hold = 300 },
	]
// ====================================================
// DO NOT EDIT UNDER THIS LINE ( OR AT YOUR OWN RISK )
// ====================================================
// CURRENT LINE OF TITLES
currentLine <- 0

// Dumps all of the CREDITS[] array
function DumpText(){
	if(DBG){
		foreach (index, credit in CREDITS) {
			printl(credit.title_text + " " + credit.subtitle_text)
		}
	}
}

// SETS SO IT FADES AT SAME TIME
function WorkOutDelay(CREDITS, index, branch) 
{
	local titleTime = 0.0
	local subtitleTime = 0.0 
	local extraDelay = 0.0

	titleTime = CREDITS[index].title_text.len() * 0.05
	subtitleTime = CREDITS[index].subtitle_text.len() * 0.05

	if(branch == 0) 
	{
		extraDelay = subtitleTime - titleTime
	}
	else 
	{
		extraDelay = titleTime - subtitleTime
	}

	if(extraDelay <= 0)
	{
		return 0
	}
	return extraDelay
}

// CREDITS
function DisplayText() 
{	
	EntFire( "@chapter_subtitle_text", "SetTextColor", "210 210 210 128", 0.0 )
	EntFire( "@chapter_subtitle_text", "SetTextColor2", "50 90 116 128", 0.0 )
	EntFire( "@chapter_title_text", "SetTextColor", "210 210 210 128", 0.0 )
	EntFire( "@chapter_title_text", "SetTextColor2", "50 90 116 128", 0.0 )
	
	foreach (index, credit in CREDITS) 
	{		
		if ( index == currentLine ) 
		{
			local notDefault = false
			if ("reversed" in credit) {
				if(credit.reversed) {
					EntFire( "@chapter_title_text", "SetPosY", "0.4", 0.0 ) 
					EntFire( "@chapter_subtitle_text", "SetPosY", "0.32", 0.0 )
				}
				notDefault = true
			}
			if ("position" in credit)
			{
				local subPos = credit.position + 0.08
				
				EntFire( "@chapter_title_text", "SetPosY", credit.position, 0.0 ) 
				EntFire( "@chapter_subtitle_text", "SetPosY", subPos, 0.0 )

				notDefault = true
			}
			if (!notDefault) 
			{
				// DEFAULT TEXT POSITIONS
				EntFire( "@chapter_title_text", "SetPosY", "0.32", 0.0 ) 
				EntFire( "@chapter_subtitle_text", "SetPosY", "0.4", 0.0 )
			}

			// Title and subtitle fade at same time from delays
			local delay1 = (WorkOutDelay(CREDITS, index, 0) + credit.hold)
			local delay2 = (WorkOutDelay(CREDITS, index, 1) + credit.hold)

			// Timing setup
			local longerDelay = 0.0
			if( delay1 > delay2 ){ longerDelay = delay1 }
			else{ longerDelay = delay2 }
			local triggerTime = credit.delay + longerDelay
			if(DBG) printl("triggerTime: " + triggerTime)


			// CHANGES TEXT CONTENTS, DISPLAYS AND ADDS DELAY TO TEXT FADE
			EntFire( "@chapter_subtitle_text", "AddOutput", "holdtime " + delay2, 0.0 )
			EntFire( "@chapter_title_text", "AddOutput", "holdtime " + delay1, 0.0 )

			EntFire( "@chapter_title_text", "SetText", credit.title_text, 0.0 )
			EntFire( "@chapter_subtitle_text", "settext", credit.subtitle_text, 0.0 )
			EntFire( "@chapter_title_text", "display", "", credit.delay )
			EntFire( "@chapter_subtitle_text", "display", "", credit.delay )

			EntFire( "@toggleCredits", "Trigger", "", triggerTime )
		}
	}
	currentLine++
	
	//Credits are finished. Disconnect the player
	if(currentLine > CREDITS.len())
	{
		EntFire( "@clientcommand", "Command", "Disconnect", 0.0)	
	}
}