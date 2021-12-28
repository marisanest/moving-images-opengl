# Moving Images with OpenGL

## glslViewer

> glslViewer 001.frag -w 1080 -h 1920 --headless -E sequence,0,10,30

## Ffmpeg
 
> ffmpeg -r 30 -i %05d.png -c:v libx264 -pix_fmt yuv420p 001.mp4

## Gimp

> gimp -b - -i
> (smileyb)