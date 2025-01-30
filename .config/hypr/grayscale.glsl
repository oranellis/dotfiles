precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 this_colour = texture2D( tex, v_texcoord );
    float grayscale = 0.6;
    float r = ((1.0-grayscale) * this_colour.r) + (grayscale * (this_colour.r+this_colour.g+this_colour.b)/3.0);
    float g = ((1.0-grayscale) * this_colour.g) + (grayscale * (this_colour.r+this_colour.g+this_colour.b)/3.0);
    float b = ((1.0-grayscale) * this_colour.b) + (grayscale * (this_colour.r+this_colour.g+this_colour.b)/3.0);
    gl_FragColor = vec4(r,g,b,1.0);
}
