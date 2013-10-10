uniform sampler2D	colors;
uniform sampler2D	kinect;
uniform sampler2D	positions;
uniform sampler2D	velocities;

uniform float		dampen;
uniform vec3		center;
uniform float		speed;

varying vec2		uv;

void main ( void )
{
	vec3 destination;
	destination.x		= uv.s;
	destination.y		= uv.t;
	destination.z		= 1.0 - texture2D( kinect,		uv ).r;
	vec3 position		= texture2D( positions,		uv ).rgb;
	vec3 velocity		= texture2D( velocities,	uv ).rgb;
	
	velocity			+= normalize( destination - position ) * speed;
	velocity			+= normalize( center - position ) * speed * 0.5;

	position			+= velocity;
	velocity			*= dampen;

	position			= destination;

	gl_FragData[ 0 ]	= vec4( position, 1.0 );
	gl_FragData[ 1 ]	= vec4( velocity, 1.0 );
}
 