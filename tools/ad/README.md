The 30-second ad (images/ad.gif). Open ad.html in a browser to watch it live.

To re-render:

    node capture.mjs ad.html /tmp/shelfie-frames 15
    ffmpeg -framerate 15 -i /tmp/shelfie-frames/f%04d.png -vf "fps=12,scale=900:-1:flags=lanczos,split[a][b];[a]palettegen=max_colors=128:stats_mode=diff[p];[b][p]paletteuse=dither=bayer:bayer_scale=5:diff_mode=rectangle" ../../images/ad.gif

For a review copy with a timer in the corner: `Q='&stamp' node capture.mjs ...`, then encode the frames to an MP4.
