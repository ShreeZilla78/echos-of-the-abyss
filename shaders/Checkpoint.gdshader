shader_type spatial;

uniform float speed = 1.0;
uniform vec4 my_color : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment(){
  COLOR = my_color;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
