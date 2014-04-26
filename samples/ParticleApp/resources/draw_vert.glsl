#version 330 core

uniform mat4 		ciModelViewProjection;
uniform float		uDepth;
uniform float		uTime;
uniform sampler2D	uTexturePosition;

in vec2 			ciTexCoord0;
in vec4 			ciPosition;

out vec4			vColor;

void main( void ) 
{
	vec2 uv			= ciTexCoord0;

	vec4 position 	= ciPosition;
	position.z		= texture( uTexturePosition, uv ).b;

	vColor			= vec4( uv.s * ( 1.0 - position.z ) + 0.5, 0.5 - position.z * 0.5, uv.t * ( position.z * 0.5 ) + 0.1, position.z );
	vColor.rgb		+= sin( uTime * 0.5 ) * 0.2;
	vColor			= clamp( vColor * 0.5 + 0.5 * vColor * vColor * 8.0, 0.0, 1.0 );

	position.x		*= -2.0;
	position.z		*= uDepth + sin( uTime + uv.s * 10.0 ) * ( uDepth * 0.033 );

	gl_Position		= ciModelViewProjection * position;
}
 