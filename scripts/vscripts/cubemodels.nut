function setCubeModel(cube){
	if(cube == null)
		Entities.FindByName(null,"Test_Cube").SetModel("models/props/metal_boy.mdl")
	else
		cube.SetModel("models/props/metal_boy.mdl")
}

function setCubes() {      
	local current = null

	while((current = Entities.FindByName(current,"Test_Cube1")) != null){
		if ( current.IsValid() ){ 
			setCubeModel(current)
		}
	}
	//you shouldnt set global variables inside a function
}

setCubes()