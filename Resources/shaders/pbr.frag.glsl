#version 330 core

in vec4 fPosLS;
in vec3 Normal;
in vec3 WorldPos;
in vec2 TexCoords;

// Shadow
uniform sampler2D shadowDepth;

// Textures
uniform sampler2D albedoMap;
uniform sampler2D roughnessMap;
uniform sampler2D metallicMap;
// uniform sampler2D aoMap;

// Material parameters
// uniform vec3 albedo;
// uniform float roughness;
// uniform float metallic;
// uniform float ao;
const float ao = 0;

// Lights
uniform vec3 lightPosition;
uniform vec3 lightColor;

uniform vec3 viewPos;

uniform bool shadows;
uniform float shadowSize;
uniform float shadowAA;

out vec4 FragColor;

const float PI = 3.14159265359;

float distributionGGX(vec3 N, vec3 H, float roughness) {
	float a = roughness*roughness;
	float a2 = a*a;
	float NdotH = max(dot(N, H), 0.0);
	float NdotH2 = NdotH*NdotH;

	float num = a2;
	float denom = (NdotH2 * (a2 - 1.0) + 1.0);
	denom = PI * denom * denom;

	return num / denom;
}

float geometrySchlickGGX(float NdotV, float roughness) {
	float r = (roughness + 1.0);
	float k = (r*r) / 8.0;

	float num = NdotV;
	float denom = NdotV * (1.0 - k) + k;

	return num / denom;
}
float GeometrySmith(vec3 N, vec3 V, vec3 L, float roughness) {
	float NdotV = max(dot(N, V), 0.0);
	float NdotL = max(dot(N, L), 0.0);
	float ggx2 = geometrySchlickGGX(NdotV, roughness);
	float ggx1 = geometrySchlickGGX(NdotL, roughness);

	return ggx1 * ggx2;
}
vec3 fresnelSchlick(float cosTheta, vec3 F0) {
	return F0 + (1.0 - F0) * pow(1.0 - cosTheta, 5.0);
}

// returns 1 if shadowed
// called with the point projected into the light's coordinate space
float TestShadow(vec4 LSfPos) {
	// 1: shift the coordinates from -1, 1 to 0 ,1
	vec3 shifted = (LSfPos.xyz + vec3(1)) * 0.5;

	// 2: read off the stored depth (.) from the ShadowDepth, using the shifted.xy 
	float Ldepth = texture(shadowDepth, shifted.xy).r;
		
	// 3: compare to the current depth (.z) of the projected depth
	if (Ldepth < shifted.z - 0.0001)
	{
		//4: return 1 if the point is shadowed
		return 1.0f;
	}

	return 0.0;
}

float getShadeValue() {
	float Shade = 0.0f;
	//shadow

	if (shadows)
	{
		float increment = (1.0f / shadowSize);
		float halfIncrement = (increment / 2.0f);

		float startX = (fPosLS.x - ((shadowAA + 1.0f) * halfIncrement));
		float startY = (fPosLS.y - ((shadowAA + 1.0f) * halfIncrement));

		vec4 startSample = vec4(startX, startY, fPosLS.z, fPosLS.w);
		vec4 subSample = startSample;

		for (float i = 0.0f; i < shadowAA; i++)
		{
			for (float j = 0.0f; j < shadowAA; j++)
			{
				subSample.x = startX + (i * increment);
				subSample.y = startY +  (j * increment);
				Shade += TestShadow(subSample);
			}
		}
		Shade = Shade / (shadowAA * shadowAA);
	}

	return Shade;
}

void main() {
	vec3 albedo = texture(albedoMap, TexCoords).rgb;
	albedo = vec3(pow(albedo.r, 2.2), pow(albedo.g, 2.2), pow(albedo.b, 2.2));
	float metallic  = texture(metallicMap, TexCoords).r;
	float roughness = texture(roughnessMap, TexCoords).r;
	// float roughness = 0.5;

	vec3 N = normalize(Normal);
	vec3 V = normalize(viewPos - WorldPos);

	vec3 F0 = vec3(0.04);
	F0 = mix(F0, albedo, metallic);

	// reflectance equation
	vec3 Lo = vec3(0.0);
	// Calculate the light's radiance
	vec3 L = normalize(lightPosition - WorldPos);
	vec3 H = normalize(V + L);
	float distance = length(lightPosition - WorldPos);
	float attenuation = 1.0 / (distance * distance);
	vec3 radiance = lightColor * attenuation;

	// Cook-Torrance BRDF
	float NDF = distributionGGX(N, H, roughness);
	float G = GeometrySmith(N, V, L, roughness);
	vec3 F = fresnelSchlick(max(dot(H, V), 0.0), F0);

	vec3 kS = F;
	vec3 kD = vec3(1.0) - kS;
	kD *= 1.0 - metallic;

	vec3 numerator = NDF * G * F;
	float denominator = 4.0 * max(dot(N, V), 0.0) * max(dot(N, L), 0.0);
	vec3 specular = numerator / max(denominator, 0.001);

	// Add to outgoing radiance Lo
	float NdotL = max(dot(N, L), 0.0);
	Lo += (kD * albedo / PI + specular) * radiance * NdotL;

	// Final color factor combination
	vec3 ambient = vec3(0.03) * albedo * ao;
	vec3 color = ambient + Lo;

	// Gamma correction
	color = color / (color + vec3(1.0));
	color = pow(color, vec3(1.0/2.2));
	color *= (1.0 - getShadeValue()) * 0.75 + 0.25;

	FragColor = vec4(color, 1.0);
}