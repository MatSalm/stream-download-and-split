import subprocess
import os
import sys

FULL_VIDEO = "full_video_720p_retry.mp4"

SEGMENTS = [
    ("00:47:35", "00:53:20", "01_intro_jennie_gloria_annie_720p"),
    ("01:27:00", "01:35:37", "02_worship_give_me_jesus_720p"),
    ("01:35:37", "02:11:11", "03_jennie_allen_720p"),
    ("02:11:11", "02:22:34", "04_worship_power_in_the_name_720p"),
    ("02:29:46", "03:01:43", "05_matt_chandler_720p"),
    ("03:01:43", "03:06:00", "06_matt_and_jennie_720p"),
    ("03:12:56", "03:19:24", "07_worship_the_blood_720p"),
    ("03:56:38", "04:28:40", "08_francis_720p"),
]

def extract_segments():
    if not os.path.exists(FULL_VIDEO):
        print(f"Error: '{FULL_VIDEO}' not found.")
        sys.exit(1)

    for start, end, name in SEGMENTS:
        output = f"{name}.mp4"
        print(f"Creating {output} from {start} to {end}")

        result = subprocess.run([
            "ffmpeg",
            "-y",
            "-ss", start,
            "-to", end,
            "-i", FULL_VIDEO,
            "-c", "copy",
            output
        ])

        if result.returncode != 0:
            print(f"Failed: {output}")
            sys.exit(1)

        if not os.path.exists(output):
            print(f"Failed: {output} was not created")
            sys.exit(1)

        size_mb = os.path.getsize(output) / (1024 * 1024)
        print(f"Saved: {output} ({size_mb:.1f} MB)")

    print("\nDone. All files created successfully.")

if __name__ == "__main__":
    extract_segments()