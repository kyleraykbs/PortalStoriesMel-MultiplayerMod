//Set up old aperture turrets!

didSetTurrets <- false;
	
//----NOTE
//  Unless you place the sicklebrick/v_turr.mdl explicitly somewhere in your map,
//  then it's not precached and the game will crash when you run this script.
//  just hide one inside a wall somewhere with Rendermode: Don't Render
//  and nobody will find it.

function setTurrets(){		
		baboo <- null;
		while((baboo = Entities.FindByClassname(baboo,"prop_testchamber_door")) != null){
				
				if ( baboo.IsValid() ){
					baboo.SetModel("models/props/portal_door_dirty.mdl");
				}
						
		}
		didSetTurrets <- true;
}


setTurrets();
printl("If you're seeing this, the turret has been properly swapped" + UniqueString() );
