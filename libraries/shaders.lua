shaders = {}

shaders.BandWshader = love.graphics.newShader[[
vec4 effect(vec4 color, Image image, vec2 uvs, vec2 screen_coords) {
    vec4 pixel = Texel(image, uvs);

    float av = (pixel.r + pixel.g + pixel.b) / 3.0;

    return vec4(av, av, av, 1.0);
}
]]

shaders.battle_fog_shader = love.graphics.newShader[[
#define NUM_LIGHTS 32
struct Light {
    vec2 position;
    vec3 diffuse;
    float power;
};
extern Light lights[NUM_LIGHTS];
extern int num_lights;
extern vec2 screen;
const float constant = 1.0;
const float linear = 0.09;
const float quadratic = 0.032;
vec4 effect(vec4 color, Image image, vec2 uvs, vec2 screen_coords){
    vec4 pixel = Texel(image, uvs);
    vec2 norm_screen = screen_coords / screen;
    vec3 diffuse = vec3(0);
    for (int i = 0; i < num_lights; i++) {
        Light light = lights[i];
        vec2 norm_pos = light.position / screen;
        
        float distance = length(norm_pos - norm_screen) * light.power;
        float attenuation = 1.0 / (constant + linear * distance + quadratic * (distance * distance));
        diffuse += light.diffuse * attenuation;
    }
    diffuse = clamp(diffuse, 0.0, 1.0);
    return pixel * vec4(diffuse, 1.0);
    
}
]]

shaders.Hole_punch_shader = love.graphics.newShader[[
    extern number X = 0;
    extern number Y = 0;
    extern number Size = 1
    number radius = 100 * Size;
    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
        number distance = pow(pow(screen_coords.x - X, 2) + pow(screen_coords.y - Y, 2), 0.5);
        if (distance < radius) {
            return vec4(0, 0, 0, 0);
        }
        else {
            return vec4(0, 0, 0, 1);
        } 
    }
]]

shaders.trueLight = love.graphics.newShader[[
    extern number X = 0;
    extern number Y = 0;

    number radius = 200;
    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
        number distance = pow(pow(screen_coords.x - X, 2) + pow(screen_coords.y - Y, 2), 0.5);
        number alpha = distance / radius;
        return vec4(0, 0, 0, alpha);
    }
]]