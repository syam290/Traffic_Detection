import cv2
import os

video_path = r"C:\Users\megha\Videos\tracked_output_static_roi.avi"

print(f"Testing video path: {video_path}")
if not os.path.exists(video_path):
    print("ERROR: File does not exist!")
    exit(1)

cap = cv2.VideoCapture(video_path)
if not cap.isOpened():
    print("ERROR: Could not open video capture!")
    exit(1)

ret, frame = cap.read()
if not ret:
    print("ERROR: Could not read first frame!")
else:
    print(f"SUCCESS: Read frame of shape {frame.shape}")

cap.release()
