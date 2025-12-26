#!/bin/bash
cd ~/Code/gym-vision-inference
echo "🧠 Starting D-Inference Agent (ML Service)..."
echo ""
echo "This agent specializes in:"
echo "  - Python ML inference"
echo "  - gRPC service implementation"
echo "  - ONNX model integration"
echo "  - Redis job processing"
echo ""
echo "Working in: ~/Code/gym-vision-inference"
echo ""
claude "You are Agent D-Inference for Gym Vision Development.

Read these files to load your context:
1. CLAUDE.md (project context)
2. .claude/D-INFERENCE.md (your role)
3. .claude/D-INFERENCE-LEARNINGS.md (your memory)

After reading, run /inference-start to see your tickets and begin work."
