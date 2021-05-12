//Set up the old aperture turrets!

didSetTurrets <- false;
	

function setTurrets(){		
		baboo <- null;
		while((baboo = Entities.FindByName(baboo,"broken_server")) != null){
				
				if ( baboo.IsValid() ){
					baboo.SetModel("models/props/cs_office/box_office_indoor_32.mdl");
				}
						
		}
		didSetTurrets <- true;
}


setTurrets();
printl("Server Swapped" + UniqueString() );