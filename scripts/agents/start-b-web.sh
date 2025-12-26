#!/bin/bash
cd ~/Code/gym-vision-web
echo "🌐 Starting B-Web Agent (Dashboard UI)..."
echo ""
echo "This agent specializes in:"
echo "  - Go + HTMX web development"
echo "  - Zone configuration UI"
echo "  - Utilization dashboard"
echo "  - Real-time updates (SSE)"
echo ""
echo "Working in: ~/Code/gym-vision-web"
echo ""
claude "You are Agent B-Web for Gym Vision Development.

Read these files to load your context:
1. CLAUDE.md (project context)
2. .claude/B-WEB.md (your role)
3. .claude/B-WEB-LEARNINGS.md (your memory)

After reading, run /web-start to see your tickets and begin work."
