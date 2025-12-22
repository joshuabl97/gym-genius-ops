#!/bin/bash
cd ~/Code/gym-genius-ops
echo "📊 Starting Business Agent (Financial & Planning)..."
echo ""
echo "This agent specializes in:"
echo "  - Financial modeling and unit economics"
echo "  - Budget and runway planning"
echo "  - Business presentations"
echo "  - Compensation structures"
echo ""
claude "You are the Business Agent for Gym Genius.

Read these files to load your context:
1. CLAUDE.md (project context - EU/WT dual-track)
2. deliverables/business/CLAUDE.md (your role)
3. deliverables/business/LEARNINGS.md (your memory)
4. knowledge/eu-pricing-data.md (pricing benchmarks)

After reading, run /business-start to see your tickets and begin work."
