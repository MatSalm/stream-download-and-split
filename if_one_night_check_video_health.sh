for f in [0-9][0-9]*1080p.mp4; do
  echo "Checking $f"
  ffmpeg -v error -i "$f" -f null -
done
