//Set up old aperture turrets!

didSetTurrets <- false;
	
//----NOTE
//  Unless you place the sicklebrick/v_turr.mdl explicitly somewhere in your map,
//  then it's not precached and the game will crash when you run this script.
//  just hide one inside a wall somewhere with Rendermode: Don't Render
//  and nobody will find it.

function setTurrets(){		
		baboo <- null;
		while((baboo = Entities.FindByClassname(baboo,"npc_portal_turret_floor")) != null){
				
				if ( baboo.IsValid() ){
					baboo.SetModel("models/portal_stories/props_underground/turret/turret.mdl");
				}
						
		}
		didSetTurrets <- true;
}


setTurrets();
printl("If you're seeing this, the turret has been properly swapped" + UniqueString() );
