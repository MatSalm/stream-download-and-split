Resi Video Downloader and Segmenter

Simple tools for downloading streamed video and cutting it into clean, labeled clips.

This repo started as a practical solution for archiving long church events and breaking them into usable segments without losing quality or spending hours re-encoding.


Overview

This project supports two common video delivery types:

DASH / HLS streams (Resi, Vimeo, etc.)

Direct MP4 delivery (Lifeway, Brightcove)

It handles downloading, merging (when needed), and fast segment extraction.


Features

Downloads protected streams using browser session cookies

Supports DASH, HLS, and direct MP4 sources

Merges audio and video automatically when required

Splits full recordings into clips without re-encoding

Works well for long-form content like conferences, services, and teaching series


Requirements

Python 3

yt-dlp

ffmpeg

Install (Mac)
brew install yt-dlp
brew install ffmpeg
Downloading Video
1. DASH / HLS Streams

Used by platforms like Resi.

These streams separate video and audio and require merging.

720p
yt-dlp --cookies-from-browser firefox -f 3+8 -N 1 --fragment-retries 50 --retries 20 --merge-output-format mp4 -o full_video_720p.mp4 "STREAM_URL"
1080p
yt-dlp --cookies-from-browser firefox -f 2+8 -N 1 --fragment-retries 50 --retries 20 --merge-output-format mp4 -o full_video_1080p.mp4 "STREAM_URL"

Format notes:

2 = 1080p video

3 = 720p video

8 = audio

2. Direct MP4 (Lifeway / Brightcove)

Some platforms expose a direct video file instead of a stream. Lifeway commonly uses Brightcove, which provides a signed MP4.

How to find it

Open the video page

Press F12 → Network

Filter for mp4

Look for main.mp4

Copy the full URL

Download
yt-dlp --continue --retries 20 -o lifeway_video.mp4 "MP4_URL"

or

curl -L -o lifeway_video.mp4 "MP4_URL"

Notes:

URLs are temporary (signed CDN links)

You may need to refresh the page to get a new one

These are often fallback files (typically 720p)

Optional: Upscaling to 1080p

If the source is limited to 720p, you can upscale it for better display on large screens.

ffmpeg -i lifeway_video.mp4 \
-vf "hqdn3d=1.5:1.5:6:6,scale=1920:1080:flags=lanczos,unsharp=7:7:1.0" \
-c:v libx264 -crf 16 -preset slow \
-c:a copy \
lifeway_video_1080p.mp4

This improves presentation quality but does not restore lost detail.


Segment Extraction

After downloading the full video:

python cut_segments.py

Example output:

01_intro_jennie_gloria_annie.mp4
02_worship_give_me_jesus.mp4
03_jennie_allen.mp4
04_worship_power_in_the_name.mp4
...

Each segment is created with:

ffmpeg -ss START -to END -i full_video.mp4 -c copy output.mp4

Because the streams are copied:

no re-encoding

no quality loss

very fast processing


Workflow Summary

Identify how the video is delivered (stream vs direct MP4)

Download using yt-dlp or curl

Optionally upscale for display

Run segmentation script


Notes

If a page URL fails, check the Network tab for the real media source

Brightcove often exposes main.mp4 directly

HLS/DASH streams usually offer higher quality than fallback MP4 files


Use Cases

Church services and conferences

Training content

Archival recordings

Speaker-based clip generation


Disclaimer

Use responsibly and ensure you have permission to download and process the content.
