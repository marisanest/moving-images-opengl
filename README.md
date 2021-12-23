# Moving Images with OpenGL

## glslViewer

> glslViewer <file_name>.frag -w 1080 -h 1920 --headless -E sequence,<A_sec>,<B_sec>[,fps]

## Ffmpeg
 
> ffmpeg -r 60 -i %05d.png -c:v libx264 -pix_fmt yuv420p out.mp4

## Gimp

> gimp -b - -i
> (smileyb)