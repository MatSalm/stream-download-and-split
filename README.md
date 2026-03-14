Resi Video Downloader and Segmenter

This repository contains a small set of scripts used to download a streamed video and split it into labeled clips. The workflow uses yt-dlp to download the video and ffmpeg to extract segments based on timestamps.

The project was created to make it easy to archive a long streamed event and generate individual clips for specific speakers or sections.

What this project does

Downloads a DASH-streamed video from a manifest URL using yt-dlp

Merges the video and audio streams into a single MP4 file

Uses ffmpeg to cut the full recording into named segments

The segmentation process does not re-encode the video, so clips are created very quickly and maintain the original quality.

Requirements

You will need the following tools installed:

Python 3

yt-dlp

ffmpeg

Install with Homebrew (Mac)
brew install yt-dlp
brew install ffmpeg
Downloading the video

The stream is delivered using DASH, which means the video and audio tracks are downloaded separately and then merged.

720p download
yt-dlp --cookies-from-browser firefox -f 3+8 -N 1 --fragment-retries 50 --retries 20 --merge-output-format mp4 -o full_video_720p_retry.mp4 "STREAM_URL"

Format breakdown:

3 = 720p video stream

8 = audio stream

Expected file size: about 5 GB

1080p download
yt-dlp --cookies-from-browser firefox -f 2+8 -N 1 --fragment-retries 50 --retries 20 --merge-output-format mp4 -o full_video_1080p_retry.mp4 "STREAM_URL"

Format breakdown:

2 = 1080p video stream

8 = audio stream

Expected file size: about 7–8 GB

Segment extraction

After downloading the full video, run the Python script to generate clips.

Example command:

python cut_segments.py

The script reads a list of timestamps and produces individual MP4 files.

Example segments:

01_intro_jennie_gloria_annie.mp4
02_worship_give_me_jesus.mp4
03_jennie_allen.mp4
04_worship_power_in_the_name.mp4
05_matt_chandler.mp4
06_matt_and_jennie.mp4
07_worship_the_blood.mp4
08_francis.mp4

Each clip is created using:

ffmpeg -ss START -to END -i full_video.mp4 -c copy output.mp4

Because the streams are copied instead of re-encoded, the extraction process runs very quickly.
