#downloaded the youtube video with max quality available of 720p
yt-dlp --extractor-args "youtube:player_client=android" -f "bestvideo[height<=720]+bestaudio/best[height<=720]" --merge-output-format mp4 -o "%(title)s.%(ext)s" "https://www.youtube.com/watch?v=DI527xGJwNE"


#using spline to enhance the 720p lyric video to 1080p
ffmpeg -i "Praise To the Lord w/Joyful Joyful (Shane & Shane) Lyric Video.mp4" \
-vf "scale=1920:1080:flags=spline+accurate_rnd,unsharp=7:7:1.3:7:7:0.0" \
-c:v libx264 -crf 17 -preset slow \
-c:a copy \
"Praise_To_the_Lord_1080p_spline.mp4"#downloaded the youtube video with max q


#download the LifeWay video
yt-dlp \
--continue \
--retries 20 \
-o lifeway_video.mp4 \
"https://house-fastly-signed-us-east-1-prod.brightcovecdn.com/media/v1/pmp4/static/clear/2034960640001/43952c22-c805-4009-a380-a9cc2664e0b4/85e95ef2-30b6-431a-baf3-5a315af58568/main.mp4?fastly_token=NjliOGFjOGFfNDllOTExMWM3MzYwODUxNjhjYWVmZWQ2NmQxMjJkOWQyMTAwMzUwMDA4OGJhOGQ4ZTI3MTgxYmY5MWZlOGVkZF8vL2hvdXNlLWZhc3RseS1zaWduZWQtdXMtZWFzdC0xLXByb2QuYnJpZ2h0Y292ZWNkbi5jb20vbWVkaWEvdjEvcG1wNC9zdGF0aWMvY2xlYXIvMjAzNDk2MDY0MDAwMS80Mzk1MmMyMi1jODA1LTQwMDktYTM4MC1hOWNjMjY2NGUwYjQvODVlOTVlZjItMzBiNi00MzFhLWJhZjMtNWEzMTVhZjU4NTY4L21haW4ubXA0"


#enhance the 720p LifeWay video
ffmpeg -i lifeway_video.mp4 \ -vf "hqdn3d=1.5:1.5:6:6,scale=1920:1080:flags=lanczos+accurate_rnd+full_chroma_int,unsharp=7:7:1.0:7:7:0.0" \ -c:v libx264 -crf 16 -preset slow \ -c:a copy \ lifeway_video_1080p_experimental_strong.mp4


#Check Lifeway new video qulaity
ffprobe -v error -select_streams v:0 \
-show_entries stream=codec_name,width,height,bit_rate,avg_frame_rate \
-of default=noprint_wrappers=1 \
lifeway_video_1080p_experimental_strong.mp4
