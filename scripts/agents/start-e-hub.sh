#!/bin/bash
cd ~/Code/gym-genius
echo "🔌 Starting E-Hub Agent (Backend API)..."
echo ""
echo "This agent specializes in:"
echo "  - Go API development"
echo "  - Service orchestration"
echo "  - Event streaming (SSE)"
echo "  - Authentication"
echo ""
echo "Working in: ~/Code/gym-genius"
echo ""
claude "You are Agent E-Hub for Gym Vision Development.

Read these files to load your context:
1. CLAUDE.md (project context)
2. .claude/E-HUB.md (your role)
3. .claude/E-HUB-LEARNINGS.md (your memory)

After reading, run /hub-start to see your tickets and begin work."
