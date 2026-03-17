# Download the video at 720p resolution
# Uses Firefox browser cookies so the request inherits the same session used by the web player
# Format 3 = 720p video stream
# Format 8 = audio stream
# DASH streams provide video and audio separately, so yt-dlp downloads both and merges them
# -N 1 forces sequential fragment downloading, which is more stable for long streams
# --fragment-retries and --retries increase tolerance to CDN fragment failures
# --merge-output-format mp4 merges video and audio into a single MP4 file
# The final output file will be saved in the Downloads folder

cd ~/Downloads
yt-dlp --cookies-from-browser firefox -f 3+8 -N 1 --fragment-retries 50 --retries 20 --merge-output-format mp4 -o full_video_720p_retry.mp4 "https://resi.media/oi-as-gfd/a79b1327-b7fd-45ab-b145-35b24f844f28/Manifest.mpd?src=emb"


# Download the video at the highest available resolution (1080p)
# Uses Firefox cookies so the download request carries the same session token as the browser
# Format 2 = 1080p video stream
# Format 8 = audio stream
# DASH streaming separates video and audio tracks, which yt-dlp merges after downloading
# -N 1 downloads fragments sequentially to avoid CDN throttling and fragment corruption
# --fragment-retries and --retries help recover from intermittent network or CDN failures
# --merge-output-format mp4 ensures the final output is a standard MP4 file
# The merged video will be saved in the Downloads folder

cd ~/Downloads
yt-dlp --cookies-from-browser firefox -f 2+8 -N 1 --fragment-retries 50 --retries 20 --merge-output-format mp4 -o full_video_1080p_retry3.mp4 "https://resi.media/oi-as-gfd/a79b1327-b7fd-45ab-b145-35b24f844f28/Manifest.mpd?src=emb"
