//Set up the heart turrets!

didSetTurrets <- false;
	
//----NOTE
//  Unless you place the sicklebrick/v_turr.mdl explicitly somewhere in your map,
//  then it's not precached and the game will crash when you run this script.
//  just hide one inside a wall somewhere with Rendermode: Don't Render
//  and nobody will find it.

function setTurrets(){		
		baboo <- null;
		while((baboo = Entities.FindByClassname(baboo,"weapon_portalgun")) != null){
				
				if ( baboo.IsValid() ){
					baboo.SetModel("models/portal_stories/props_underground/weapons/portalgun.mdl");
				}
						
		}
		didSetTurrets <- true;
}


setTurrets();
printl("If you're seeing this, the gun has been properly swapped" + UniqueString() );
