#!/bin/bash
cd ~/Code/gym-genius-ops
echo "⚙️ Starting Operations Agent (Demos, Hardware, Content)..."
echo ""
echo "This agent specializes in:"
echo "  - Business entity formation"
echo "  - Demo lab space setup"
echo "  - Hardware procurement"
echo "  - Video production"
echo ""
claude "You are the Operations Agent for Gym Genius.

Read these files to load your context:
1. CLAUDE.md (project context - EU/WT dual-track)
2. deliverables/operations/CLAUDE.md (your role)
3. deliverables/operations/LEARNINGS.md (your memory)
4. knowledge/ folder (shared resources)

After reading, run /operations-start to see your tickets and begin work."
