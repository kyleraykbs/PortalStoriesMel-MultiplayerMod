// --------------------------------------------------------
// StartVideo
// --------------------------------------------------------

ElevatorVideos <- 
[
	{ map = "sp_a3_concepts",	arrival = "aperture_appear_vert.bik", departure = "aperture_appear_vert.bik", typeOverride = 9 },
	{ map = "sp_a3_paint_fling",	arrival = "hard_light.bik", departure = "hard_light.bik", typeOverride = 12 },
	{ map = "sp_a3_faith_plate", arrival = "faithplate.bik", departure = "faithplate.bik", typeOverride = 6 },
	{ map = "sp_a3_transition", arrival = "animalking.bik", departure = "animalking.bik", typeOverride = 11  },
	{ map = "sp_a4_two_of_a_kind",	arrival = "bluescreen.bik", departure = "bluescreen.bik", typeOverride = 14 },
	{ map = "sp_a4_destroyed",	arrival = "bluescreen.bik", departure = "", typeOverride = 14 },
	{ map = "sp_a4_tb_over_goo",	arrival = "animalking.bik", departure = "animalking.bik", typeOverride = 14 },
	{ map = "sp_a4_overgrown",	arrival = "bluescreen.bik", departure = "bluescreen.bik", typeOverride = 14 },
	{ map = "sp_a4_factory",	arrival = "exercises_horiz.bik", departure = "null", typeOverride = 14 },
	
]

ARRIVAL_VIDEO <- 0
DEPARTURE_VIDEO <- 1
ARRIVAL_DESTRUCTED_VIDEO <- 2
DEPARTURE_DESTRUCTED_VIDEO <- 3

OVERRIDE_VIDEOS <- 0

FIRST_CLEAN_MAP <- "sp_mel_pti_remakes"

function Precache()
{
	if( "PrecachedVideos" in this )
	{
		// don't do anything
	}
	else
	{
		// Commenting this line out because it prevents properly re-precaching movies after loading a save game.
		// The cost is that we end up running this code below about 2x too often, but it's fairly cheap and not realtime code anyways...
		//::PrecachedVideos <- 1

		local mapName = GetMapName()
		foreach (index, level in ElevatorVideos)
		{
			if (level.map == mapName)
			{
				local movieName
				if ("additional" in level && level.additional != "" )	
				{
					movieName = "media\\" + level.additional
					//printl( "Preching movie: " + movieName )
					PrecacheMovie( movieName )
				}
				
				if ("arrival" in level && level.arrival != "" )	
				{
					movieName = "media\\"
					if( OVERRIDE_VIDEOS == 1 ) 
						movieName += "entry_emergency.bik"
					else
						movieName += level.arrival
				
					//printl( "Preching movie: " + movieName )
					PrecacheMovie( movieName )
				}
				
				if ("departure" in level && level.departure != "" )	
				{
					movieName = "media\\"
					if( OVERRIDE_VIDEOS == 1 ) 
						movieName += "exit_emergency.bik"
					else
						movieName += level.departure
				
					//printl( "Preching movie: " + movieName )
					PrecacheMovie( movieName )
				}
			}
		}
	}
}

// stubs to supress error - will delete these soon.
function StopEntryVideo(width,height)
{
}

function StopExitVideo(width,height)
{
}

function StartEntryVideo(width,height)
{
}

function StartExitVideo(width,height)
{
}

function StartDestructedEntryVideo(width,height)
{
}

function StartDestructedExitVideo(width,height)
{
}

//============================

function StopArrivalVideo(width,height)
{
	EntFire("@arrival_video_master", "Disable", "", 0)
	EntFire("@arrival_video_master", "killhierarchy", "", 1.0)
	StopVideo(ARRIVAL_VIDEO,width,height)
}

function StopDepartureVideo(width,height)
{
	EntFire("@departure_video_master", "Disable", "", 0)
	EntFire("@departure_video_master", "killhierarchy", "", 1.0)
	StopVideo(DEPARTURE_VIDEO,width,height)
}

function StopVideo(videoType,width,height)
{
	for(local i=0;i<width;i+=1)
	{
		for(local j=0;j<height;j+=1)
		{
			local panelNum = 1 + width*j + i
			local signName
			
			if (videoType == DEPARTURE_VIDEO || videoType == DEPARTURE_DESTRUCTED_VIDEO )
			{
				signName = "@departure_sign_" + panelNum
			}
			else
			{
				signName = "@arrival_sign_" + panelNum
			}
			
			EntFire(signName, "Disable", "", 0)
			EntFire(signName, "killhierarchy", "", 1.0)
		}
	}
}

function StartArrivalVideo(width,height)
{
	StartDestructedArrivalVideo(width,height)
	
//	EntFire("@arrival_video_master", "Enable", "", 0)
//	StartVideo(ENTRANCE_VIDEO,width,height)
}

function StartDepartureVideo(width,height)
{
	StartDestructedDepartureVideo(width,height)

//	EntFire("@departure_video_master", "Enable", "", 0)
//	StartVideo(DEPARTURE_VIDEO,width,height)
}

function StartDestructedArrivalVideo(width,height)
{
	local playDestructed = true
	local mapName = GetMapName()
	
	foreach (index, level in ElevatorVideos)
	{
		if (FIRST_CLEAN_MAP == level.map )
		{
			playDestructed = false
		}
		
		if (level.map == mapName && ("arrival" in level) )
		{
			if( level.arrival == "" )
				return
				
			local videoName = "media\\"
			if( OVERRIDE_VIDEOS == 1 ) 
				videoName += "entry_emergency.bik"
			else
				videoName += level.arrival
				
			//printl("Setting arrival movie to " + videoName )
			EntFire("@arrival_video_master", "SetMovie", videoName, 0)
			break
		}
	}
	
	EntFire("@arrival_video_master", "Enable", "", 0.1)
	StartVideo(playDestructed ? ARRIVAL_DESTRUCTED_VIDEO : ARRIVAL_VIDEO, width, height)
}

function StartDestructedDepartureVideo(width,height)
{
	local playDestructed = true
	local mapName = GetMapName()
	
	foreach (index, level in ElevatorVideos)
	{
		if (FIRST_CLEAN_MAP == level.map )
		{
			playDestructed = false
		}
		
		if (level.map == mapName && ("departure" in level) )
		{
			if( level.departure == "" )
				return

			local videoName = "media\\"
			if( OVERRIDE_VIDEOS == 1 ) 
				videoName += "exit_emergency.bik"
			else
				videoName += level.departure
				
			//printl("Setting departure movie to " + videoName )
			EntFire("@departure_video_master", "SetMovie", videoName, 0)
			break
		}
	}
	
	EntFire("@departure_video_master", "Enable", "", 0.1)
	StartVideo(playDestructed ? DEPARTURE_DESTRUCTED_VIDEO : DEPARTURE_VIDEO, width, height)
}

function StartVideo(videoType,width,height)
{
	local videoScaleType = 0
	local randomDestructChance = 0
	
	if( videoType == ARRIVAL_DESTRUCTED_VIDEO || videoType == DEPARTURE_DESTRUCTED_VIDEO )
	{
		videoScaleType = RandomInt(1,5)
	}
	else
	{
		videoScaleType = RandomInt(6,7)
	}
		
	local mapName = GetMapName()
	foreach (index, level in ElevatorVideos)
	{
		if (level.map == mapName)
		{
			if ("typeOverride" in level)
			{
				videoScaleType = level.typeOverride
			}
			
			if ("destructChance" in level)
			{
				randomDestructChance = level.destructChance
			}
		}
	}
	
	for(local i=0;i<width;i+=1)
	{
		for(local j=0;j<height;j+=1)
		{
			local panelNum = 1 + width*j + i
			local signName
			
			if (videoType == DEPARTURE_VIDEO || videoType == DEPARTURE_DESTRUCTED_VIDEO )
			{
				signName = "@departure_sign_" + panelNum
			}
			else
			{
				signName = "@arrival_sign_" + panelNum
			}		
					
			{
				if( randomDestructChance > RandomInt(0,100) )
				{
					EntFire(signName, "Kill", "", 0)
					continue
				}
				
				EntFire(signName, "SetUseCustomUVs", 1, 0)
				
				local uMin = (i+0.0001)/(width)
				local uMax = (i+1.0001)/(width)
				local vMin = (j+0.0001)/(height)
				local vMax = (j+1.0001)/(height)
				
				if( videoScaleType == 0 /*full elevator*/ ) 				
				{
				
				}				
				else if( videoScaleType == 1 /*stretch*/ ) 
				{
					uMin = 1.0 - (1.0-uMin)*(1.0-uMin)*(1.0-uMin)
					uMax = 1.0 - (1.0-uMax)*(1.0-uMax)*(1.0-uMax)
				}				

				else if( videoScaleType == 2 /*Mirror*/ ) 
				{					
					uMin = 4*(1.0-uMin)*uMin
					uMax = 4*(1.0-uMax)*uMax					
				}				
				
				else if( videoScaleType == 3 /*Ouroboros*/ )
				{
					uMin = ((i%12)+0.0001)/12
					uMax = ((i%12)+1.0001)/12

					if( ((i)%2) == 1 )
					{
						local temp = uMin
						uMin = uMax
						uMax = temp
					}
				}
				
				else if( videoScaleType == 4 /*Upside down*/ )
				{
					vMin = 0.99999
					vMax = 0.00001
					
					uMin = ((i%3)+0.0001)/3
					uMax = ((i%3)+1.0001)/3					
				}
				
				else if( videoScaleType == 5 /*Tiled*/ )
				{
					vMin = 0.00001
					vMax = 0.99999
					
					uMin = ((i%3)+0.0001)/3
					uMax = ((i%3)+1.0001)/3
				}

				else if( videoScaleType == 6 /*Tiled Really Big*/ )
				{
					uMin = ((i%8)+0.0001)/8
					uMax = ((i%8)+1.0001)/8
				}

				else if( videoScaleType == 7 /*Tiled Big*/ )
				{
					uMin = ((i%12)+0.0001)/12
					uMax = ((i%12)+1.0001)/12
				}

				else if( videoScaleType == 8 /*Tiled Single*/ )
				{
					uMin = 0.0001
					uMax = 0.9999
					vMin = 0.0001
					vMax = 0.9999
				}

				else if( videoScaleType == 9 /*Tiled Double*/ )
				{
					uMin = ((i%2)+0.0001)/2
					uMax = ((i%2)+1.0001)/2
				}

				else if( videoScaleType == 10 /*Two by two*/ )
				{
					vMin = 0.00001
					vMax = 0.99999
					
					uMin = ((i%2)+0.0001)/2
					uMax = ((i%2)+1.0001)/2
				}

				else if( videoScaleType == 11 /*Tiled off 1*/ )
				{
					vMin = 0.00001
					vMax = 0.99999
					
					uMin = (((i+1)%3)+0.0001)/3
					uMax = (((i+1)%3)+1.0001)/3
				}

				else if( videoScaleType == 12 /*Tiled 2x4*/ )
				{
					uMin = ((i%6)+0.0001)/6
					uMax = ((i%6)+1.0001)/6
				}

				else if( videoScaleType == 13 /*Tiled Double - with two blank*/ )
				{
					if( ((i)%4) < 2 )
					{
						uMin = ((i%2)+0.0001)/2
						uMax = ((i%2)+1.0001)/2
					}
					else
					{
						uMin = 0.97
						uMax = 0.97
					}
				}

				else if( videoScaleType == 14 /*bluescreen*/ )
				{
					if( (i%8) >= 1 &&  
						(i%8) < 7 )
					{
						uMin = (((i-1)%8)+0.0001)/6
						uMax = (((i-1)%8)+1.0001)/6
					}
					else
					{
						uMin = 0.97
						uMax = 0.97
					}
				}
								 
				EntFire(signName, "SetUMin", uMin, 0)
				EntFire(signName, "SetUMax", uMax, 0)
				EntFire(signName, "SetVMin", vMin, 0)
				EntFire(signName, "SetVMax", vMax, 0)

				EntFire(signName, "Enable", "", 0.1)
				
//				printl(signName + " " + uMin + " " + uMax + " " + vMin + " " + vMax )
			}
		}
	}
}
