#!/bin/bash
cd ~/Code/gym-vision
echo "🏗️ Starting C-Infra Agent (Infrastructure)..."
echo ""
echo "This agent specializes in:"
echo "  - Docker and Docker Compose"
echo "  - Development environment setup"
echo "  - Storage and backups"
echo "  - Network configuration"
echo ""
echo "Working in: ~/Code/gym-vision"
echo ""
claude "You are Agent C-Infra for Gym Vision Development.

Read these files to load your context:
1. CLAUDE.md (project context)
2. .claude/C-INFRA.md (your role)
3. .claude/C-INFRA-LEARNINGS.md (your memory)

After reading, run /infra-start to see your tickets and begin work."
