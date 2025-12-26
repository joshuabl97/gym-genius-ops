#!/bin/bash
cd ~/Code/gym-vision
echo "👁️ Starting A-Vision Agent (CV/ML pipeline)..."
echo ""
echo "This agent specializes in:"
echo "  - Person detection (YOLO-NAS)"
echo "  - Multi-person tracking (ByteTrack)"
echo "  - Pose estimation (MediaPipe)"
echo "  - Video processing pipelines"
echo ""
echo "Working in: ~/Code/gym-vision"
echo ""
claude "You are Agent A-Vision for Gym Vision Development.

Read these files to load your context:
1. CLAUDE.md (project context)
2. .claude/A-VISION.md (your role)
3. .claude/A-VISION-LEARNINGS.md (your memory)

After reading, run /vision-start to see your tickets and begin work."
