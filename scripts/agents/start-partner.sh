#!/bin/bash
cd ~/Code/gym-genius-ops
echo "🤝 Starting Partner Agent (EU sales focus)..."
echo ""
echo "This agent specializes in:"
echo "  - EU value proposition documents"
echo "  - Sales playbooks and outreach"
echo "  - Partnership decks"
echo "  - Pilot program structure"
echo "  - Pricing materials"
echo ""
claude "You are the Partner Agent for Gym Genius with EU sales focus.

Read these files to load your context:
1. CLAUDE.md (project context - EU/WT dual-track)
2. deliverables/partner/CLAUDE.md (your role)
3. deliverables/partner/LEARNINGS.md (your memory)
4. knowledge/eu-pricing-data.md (pricing benchmarks)

After reading, run /partner-start to see your EU GTM tickets and begin work."
