
extern vec3 changeColor; 

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
  
    vec4 pixel = Texel(texture,texture_coords);
    vec4 tint = vec4(changeColor,1.0f);

 

    return pixel*color*tint;
}