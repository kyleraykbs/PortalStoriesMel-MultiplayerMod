DoIncludeScript( "choreo/sphere_choreo_include", self.GetScriptScope() )

DialogVcd <- {}

//VCDs for placeholders:
//100-range tramride
//200-range intro
//300-range lift
//400-range garden

DialogVcd[301] <- {vcd = "scenes/npc/cave/office03.vcd", speaker = WHEATLEY, one ="As I said on the last pre-recorded message", nextline =302, nextLineDelay = 1 }
DialogVcd[302] <- {vcd = "scenes/npc/cave/office04.vcd", speaker = WHEATLEY, one = "Just remember, this is not a bed and breakfast", nextline = 303, nextLineDelay = 3 }
DialogVcd[304] <- {vcd = "scenes/npc/cave/office05.vcd", speaker = WHEATLEY, one = "Don't mind the turrets, they're just firing blanks."}

DialogVcd[305] <-{vcd = "scenes/npc/cave/office06.vcd", speaker = WHEATLEY, one = "Don't worry, those turrets won't kill you.", two="The safety on their guns is on, had some lab boys shut them down", nextline = 306}
DialogVcd[306] <-{vcd = "scenes/npc/cave/office07.vcd", speaker = WHEATLEY, one = "Well, Crazy Harry lied to me."}



function SpeakLineVcd( arg )
{
	if (arg in DialogVcd)
	{
		EntFire("@glados","RunScriptCode","GladosPlayVcd("+DialogVcd[arg]+")", 0.00)
	}
	else
	{
		SpeakLine( arg )
	}
}