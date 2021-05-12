//Set up the old aperture turrets!

didSetTurrets <- false;
	

function setTurrets(){		
		baboo <- null;
		while((baboo = Entities.FindByName(baboo,"bad_turret")) != null){
				
				if ( baboo.IsValid() ){
					baboo.SetModel("models/portal_stories/props_underground/turret/turret.mdl");
					printl("valid swapperino");
				}
				else {
					printl("what happened?");
				}
						
		}
		didSetTurrets <- true;
}


setTurrets();
printl("Turret Swapped" + UniqueString() );