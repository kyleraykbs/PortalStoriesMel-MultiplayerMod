ElevatorMotifs <- 
[
	{ map = "sp_a2_garden_destroyed", speed = 120},
	{ map = "sp_a2_underbounce", speed = 120},
	{ map = "sp_a2_once_upon", speed = 120},
	{ map = "sp_a2_past_power", speed = 120},	
	{ map = "sp_a2_dont_meet_virgil", speed = 120},
	{ map = "sp_a2_firestorm", speed = 120},
	{ map = "sp_a3_junkyard", speed = 200},
	{ map = "sp_a3_concepts", speed = 200},
	{ map = "sp_a3_paint_fling", speed = 200},
	{ map = "sp_a3_faith_plate", speed = 200},
	{ map = "sp_a4_overgrown", speed = 200},
	{ map = "sp_a4_tb_over_goo", speed = 200},
	{ map = "sp_a4_two_of_a_kind", speed = 200},
	{ map = "sp_a4_destroyed", speed = 200},
	{ map = "sp_a4_factory", speed = 200},
	{ map = "sp_a5_finale1", speed = 200},
	{ map = "st_a2_garden_destroyed", speed = 120},
	{ map = "st_a2_underbounce", speed = 120},
	{ map = "st_a2_once_upon", speed = 120},
	{ map = "st_a2_past_power", speed = 120},	
	{ map = "st_a2_dont_meet_virgil", speed = 120},
	{ map = "st_a2_firestorm", speed = 120},
	{ map = "st_a3_junkyard", speed = 200},
	{ map = "st_a3_concepts", speed = 200},
	{ map = "st_a3_paint_fling", speed = 200},
	{ map = "st_a3_faith_plate", speed = 200},
	{ map = "st_a4_overgrown", speed = 200},
	{ map = "st_a4_tb_over_goo", speed = 200},
	{ map = "st_a4_two_of_a_kind", speed = 200},
	{ map = "st_a4_destroyed", speed = 200},
	{ map = "st_a4_factory", speed = 200},
	{ map = "st_a5_finale1", speed = 200},
]

function StartMoving()
{
	SendToConsole( "map_wants_save_disable 1" )	
	
	local foundLevel = false
	
	foreach (index, level in ElevatorMotifs)
	{
		if (level.map == GetMapName() && ("speed" in level) )
		{
			printl( "Starting elevator " + self.GetName() + " with speed " + level.speed )
			EntFire(self.GetName(),"SetSpeedReal",level.speed,0.0)
			foundLevel = true
		}
	}
	
	if (foundLevel == false) 
	{
		printl( "Using default elevator speed 300" )
		EntFire(self.GetName(),"SetSpeedReal","300",0.0)
	}
}

function ReadyForTransition()
{
	// see if we need to teleport to somewhere else or 
	PrepareTeleport()
}

function FailSafeTransition()
{
	// fire whichever one of these we have.
	EntFire("@transition_from_map","Trigger","",0.0)
	EntFire("@transition_with_survey","Trigger","",0.0)
}

function PrepareTeleport()
{	
	local foundLevel = false
		
	if ( ::TransitionFired == 1 )
		return

	foreach (index, level in ElevatorMotifs)
	{
		if ( level.map == GetMapName() )
		{
			if ("motifs" in level)
			{
				printl( "Trying to connect to motif " + level.motifs[::MotifIndex] )

				if( level.motifs[::MotifIndex] == "transition" )
				{
					EntFire("@transition_with_survey","Trigger","",0.0)
					EntFire("@transition_from_map","Trigger","",0.0)
					return
				}
				else
				{
					EntFire(self.GetName(),"SetRemoteDestination",level.motifs[::MotifIndex],0.0)
					if( ::MotifIndex == 0 )
					{
						EntFire("departure_elevator-elevator_1","Stop","",0.05)
					}
				}
				foundLevel = true
			}
			else
			{
				if( ::TransitionReady == 1 )
				{
					::TransitionFired <- 1
					EntFire("@transition_from_map","Trigger","",0.0)
					EntFire("@transition_with_survey","Trigger","",0.0)
				}
				// just bail, we don't need to do anything weird here.
				return;
			}
		}
	}
	
	if (foundLevel == false)
	{
//		printl("**********************************")
//		printl("Level not found in elevator_motifs")
//		printl("**********************************")
		{
			::TransitionFired <- 1
			EntFire("@transition_with_survey","Trigger","",0.0)
			EntFire("@transition_from_map","Trigger","",0.0)
			printl("Level not found in elevator_motifs defaulting to transition")
		}

		// just bail, we don't need to do anything weird here.
		return;
	}
	
	EntFire(self.GetName(),"Enable",0.0)	
	::MotifIndex += 1
}

function OnPostSpawn()
{
	::MotifIndex <- 0
	::TransitionReady <- 0
	::TransitionFired <- 0
}