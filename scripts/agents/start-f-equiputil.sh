#!/bin/bash
cd ~/Code/gym-vision
echo "📊 Starting F-EquipUtil Agent (EU features - PRIMARY)..."
echo ""
echo "This agent specializes in:"
echo "  - Zone configuration and management"
echo "  - Zone occupancy detection"
echo "  - Utilization metrics calculation"
echo "  - Real-time occupancy tracking"
echo ""
echo "Working in: ~/Code/gym-vision"
echo ""
claude "You are Agent F-EquipUtil for Equipment Utilization features.

Read these files to load your context:
1. CLAUDE.md (project context)
2. .claude/F-EQUIPUTIL.md (your role)
3. .claude/F-EQUIPUTIL-LEARNINGS.md (your memory)

After reading, run /equiputil-start to see your EU tickets and begin work."
