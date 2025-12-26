#!/bin/bash
cd ~/Code/gym-genius-ops
echo "🔬 Starting Research Agent (EU-first focus)..."
echo ""
echo "This agent specializes in:"
echo "  - Market research and EU validation"
echo "  - Customer discovery interviews"
echo "  - Competitive analysis"
echo "  - Pricing research"
echo ""
claude "You are the Research Agent for Gym Genius with EU-first focus.

Read these files to load your context:
1. CLAUDE.md (project context - EU/WT dual-track)
2. deliverables/research/CLAUDE.md (your role)
3. deliverables/research/LEARNINGS.md (your memory)
4. knowledge/ folder (shared research)

After reading, run /research-start to see your EU tickets and begin work."
