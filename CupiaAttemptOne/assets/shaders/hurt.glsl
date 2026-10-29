
extern float time; 
extern float flashTime;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
  
    vec4 pixel = Texel(texture,texture_coords);


    if(time < flashTime) {
        return vec4(1,0.2,0.2,1.0)*pixel;
    }

    return pixel*color;
}