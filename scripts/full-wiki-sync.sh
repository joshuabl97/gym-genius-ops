#!/bin/bash
# Full sync of deliverables to Notion wiki

set -e

# Load token
if [[ -f ~/.bashrc ]]; then
    NOTION_TOKEN=$(grep -oP 'NOTION_TOKEN="\K[^"]+' ~/.bashrc 2>/dev/null || true)
    export NOTION_TOKEN
fi

if [[ -z "$NOTION_TOKEN" ]]; then
    echo "Error: NOTION_TOKEN not found" >&2
    exit 1
fi

WIKI_PAGE_ID="2cf94de2-5d4d-81f0-9890-d7302b3365d4"

notion_curl() {
    curl -s \
        -H "Authorization: Bearer $NOTION_TOKEN" \
        -H "Content-Type: application/json" \
        -H "Notion-Version: 2022-06-28" \
        "$@"
}

create_page() {
    local parent_id="$1"
    local title="$2"

    notion_curl -X POST "https://api.notion.com/v1/pages" \
        -d "{
            \"parent\": {\"page_id\": \"$parent_id\"},
            \"properties\": {
                \"title\": [{\"text\": {\"content\": \"$title\"}}]
            }
        }" | jq -r '.id'
}

append_block() {
    local page_id="$1"
    local block_json="$2"

    notion_curl -X PATCH "https://api.notion.com/v1/blocks/$page_id/children" \
        -d "{\"children\": [$block_json]}" > /dev/null
}

append_heading1() {
    local page_id="$1"
    local text="$2"
    append_block "$page_id" "{\"type\":\"heading_1\",\"heading_1\":{\"rich_text\":[{\"type\":\"text\",\"text\":{\"content\":\"$text\"}}]}}"
}

append_heading2() {
    local page_id="$1"
    local text="$2"
    append_block "$page_id" "{\"type\":\"heading_2\",\"heading_2\":{\"rich_text\":[{\"type\":\"text\",\"text\":{\"content\":\"$text\"}}]}}"
}

append_heading3() {
    local page_id="$1"
    local text="$2"
    append_block "$page_id" "{\"type\":\"heading_3\",\"heading_3\":{\"rich_text\":[{\"type\":\"text\",\"text\":{\"content\":\"$text\"}}]}}"
}

append_paragraph() {
    local page_id="$1"
    local text="$2"
    local escaped=$(echo "$text" | sed 's/"/\\"/g' | tr '\n' ' ')
    append_block "$page_id" "{\"type\":\"paragraph\",\"paragraph\":{\"rich_text\":[{\"type\":\"text\",\"text\":{\"content\":\"$escaped\"}}]}}"
}

append_callout() {
    local page_id="$1"
    local emoji="$2"
    local text="$3"
    local escaped=$(echo "$text" | sed 's/"/\\"/g' | tr '\n' ' ')
    append_block "$page_id" "{\"type\":\"callout\",\"callout\":{\"icon\":{\"type\":\"emoji\",\"emoji\":\"$emoji\"},\"rich_text\":[{\"type\":\"text\",\"text\":{\"content\":\"$escaped\"}}]}}"
}

append_divider() {
    local page_id="$1"
    append_block "$page_id" "{\"type\":\"divider\",\"divider\":{}}"
}

append_bullet() {
    local page_id="$1"
    local text="$2"
    local escaped=$(echo "$text" | sed 's/"/\\"/g')
    append_block "$page_id" "{\"type\":\"bulleted_list_item\",\"bulleted_list_item\":{\"rich_text\":[{\"type\":\"text\",\"text\":{\"content\":\"$escaped\"}}]}}"
}

append_quote() {
    local page_id="$1"
    local text="$2"
    local escaped=$(echo "$text" | sed 's/"/\\"/g' | tr '\n' ' ')
    append_block "$page_id" "{\"type\":\"quote\",\"quote\":{\"rich_text\":[{\"type\":\"text\",\"text\":{\"content\":\"$escaped\"}}]}}"
}

echo "=== Full Wiki Sync ==="
echo ""

# ============================================
# 1. UPDATE MAIN WIKI PAGE - Add Company Summary at top
# ============================================
echo "1. Adding Company Summary to main wiki page..."

# First, get the first block to insert before it
FIRST_BLOCK=$(notion_curl "https://api.notion.com/v1/blocks/$WIKI_PAGE_ID/children?page_size=1" | jq -r '.results[0].id')

# We'll prepend blocks by creating them and they'll appear at the end
# Instead, let's create a new "Company Overview" child page
OVERVIEW_ID=$(create_page "$WIKI_PAGE_ID" "Company Overview")
echo "   Created Company Overview page: $OVERVIEW_ID"

append_callout "$OVERVIEW_ID" "🎯" "Uzzage - Equipment utilization analytics for gyms, powered by computer vision."

append_heading1 "$OVERVIEW_ID" "Mission"
append_quote "$OVERVIEW_ID" "Help gym operators make data-driven equipment decisions using their existing security cameras—without compromising member privacy."

append_heading1 "$OVERVIEW_ID" "Short-Term Goals (Next 6 Months)"
append_bullet "$OVERVIEW_ID" "Land 10 pilot customers to validate product-market fit"
append_bullet "$OVERVIEW_ID" "Achieve \$57K ARR (Pilot milestone)"
append_bullet "$OVERVIEW_ID" "Complete 5-10 customer discovery calls"
append_bullet "$OVERVIEW_ID" "Refine pricing based on customer feedback"

append_heading1 "$OVERVIEW_ID" "Long-Term Goals (12-24 Months)"
append_bullet "$OVERVIEW_ID" "Scale to 175 gyms / \$1M ARR"
append_bullet "$OVERVIEW_ID" "Achieve \$10M-\$15M valuation at 10-15x ARR"
append_bullet "$OVERVIEW_ID" "Expand to regional gym chains (5-50 locations)"
append_bullet "$OVERVIEW_ID" "Build team: Founder + 1-2 employees"

append_heading1 "$OVERVIEW_ID" "Key Metrics"
append_paragraph "$OVERVIEW_ID" "Monthly Software Price: \$314-\$799 (based on sqft) | LTV: \$39,473 | LTV:CAC: 26:1 | Break-even: 6 gyms | Target Margin: 65%"

append_divider "$OVERVIEW_ID"

append_heading1 "$OVERVIEW_ID" "Three Packages"
append_paragraph "$OVERVIEW_ID" "Connect (\$359-\$718 setup): Integrate with existing cameras | Enhance (\$2,838-\$6,586 setup): Your cameras + supplementary | Complete (\$5,900-\$45,834 setup): Full turnkey installation"

# ============================================
# 2. CREATE FINANCIAL MODEL PAGE
# ============================================
echo "2. Creating Financial Model page..."

FM_ID=$(create_page "$WIKI_PAGE_ID" "Financial Model")
echo "   Created Financial Model page: $FM_ID"

append_callout "$FM_ID" "📊" "Comprehensive financial model for Uzzage. Includes unit economics, pricing, projections, and path to \$1M ARR."

append_heading1 "$FM_ID" "Executive Summary"
append_paragraph "$FM_ID" "Uzzage provides equipment utilization analytics for fitness facilities using computer vision. Three deployment models: BYOC (Connect), Hybrid (Enhance), and Full Install (Complete)."

append_heading2 "$FM_ID" "Key Metrics (65% Margin)"
append_paragraph "$FM_ID" "Monthly Software Price: \$476 avg | Hardware Cost: \$299-\$38,195 | Y1 Gross Margin: 49-84% | LTV: \$39,473 | LTV:CAC: 26:1 | Break-even: 6 gyms"

append_divider "$FM_ID"

append_heading1 "$FM_ID" "Pricing"
append_heading2 "$FM_ID" "Software (65% Margin)"
append_paragraph "$FM_ID" "Base Fee: \$246/mo + \$0.0123/sqft | Small Boutique (5,500 sqft): \$314/mo | Mid Independent (11,500 sqft): \$388/mo | Large Facility (22,500 sqft): \$523/mo | Enterprise (45,000 sqft): \$799/mo"

append_heading2 "$FM_ID" "Hardware (20% Markup)"
append_paragraph "$FM_ID" "BYOC: \$359-\$718 | Hybrid: \$2,838-\$6,586 | Full Install: \$5,900-\$45,834"

append_divider "$FM_ID"

append_heading1 "$FM_ID" "Path to \$1M ARR"
append_paragraph "$FM_ID" "At 65% margin with realistic mix (30% BYOC, 50% Hybrid, 20% Full Install):"
append_bullet "$FM_ID" "Pilot (10 gyms): \$57K ARR - Valuation \$170K-\$285K"
append_bullet "$FM_ID" "Traction (25 gyms): \$143K ARR - Valuation \$715K-\$1M"
append_bullet "$FM_ID" "Growth (50 gyms): \$286K ARR - Valuation \$2M-\$2.9M"
append_bullet "$FM_ID" "Scale (100 gyms): \$571K ARR - Valuation \$4.6M-\$6.9M"
append_bullet "$FM_ID" "\$1M ARR (175 gyms): Valuation \$10M-\$15M"

append_heading2 "$FM_ID" "Profitability at \$1M ARR"
append_paragraph "$FM_ID" "Software MRR: \$83,300 | COGS: \$15,050/mo | Gross Profit: \$68,250/mo (82%) | OpEx: \$27,500/mo | Net Profit: \$40,750/mo (49%)"

append_divider "$FM_ID"

append_heading1 "$FM_ID" "Unit Economics"
append_heading2 "$FM_ID" "BYOC Model (Best Margins)"
append_paragraph "$FM_ID" "Small Boutique: 68% margin | Mid Independent: 73% margin | Large Facility: 79% margin | Enterprise: 84% margin"

append_heading2 "$FM_ID" "Hybrid Model"
append_paragraph "$FM_ID" "Small Boutique: 49% margin | Mid Independent: 52% margin | Large Facility: 55% margin | Enterprise: 60% margin"

append_paragraph "$FM_ID" "Recommendation: Prioritize BYOC where eligible, then Hybrid. Full Install only when necessary."

append_divider "$FM_ID"

append_heading1 "$FM_ID" "Customer Lifetime Value"
append_paragraph "$FM_ID" "At 12% annual churn: Avg Lifetime 100 months | Lifetime Revenue \$47,600 | Lifetime COGS \$8,600 | LTV \$39,473"

append_heading1 "$FM_ID" "Customer Acquisition Cost"
append_paragraph "$FM_ID" "Founder-led: \$1,000 (39:1 LTV:CAC) | Partner referral: \$2,000 (20:1) | Inbound marketing: \$3,000 (13:1) | Blended target: \$1,500 (26:1)"

# ============================================
# 3. UPDATE ONE-PAGER PAGE (delete old, create new with full content)
# ============================================
echo "3. Creating complete One-Pager page..."

OP_ID=$(create_page "$WIKI_PAGE_ID" "Sales One-Pager")
echo "   Created Sales One-Pager page: $OP_ID"

append_callout "$OP_ID" "📄" "Customer-facing one-pager for gym owners. Print or share digitally during sales conversations."

append_heading1 "$OP_ID" "Know Which Equipment Your Members Actually Use"
append_paragraph "$OP_ID" "Equipment utilization analytics for gyms—powered by your existing security cameras."

append_divider "$OP_ID"

append_heading2 "$OP_ID" "The Problem"
append_paragraph "$OP_ID" "You buy equipment based on gut feel. You guess which machines are popular. You don't know what's gathering dust—until members complain or you see it empty every day."
append_quote "$OP_ID" "Result: Wasted capital on underused equipment. Overcrowded zones that frustrate members."

append_heading2 "$OP_ID" "What We Do"
append_paragraph "$OP_ID" "We use your existing security cameras to show you exactly which equipment gets used, when, and for how long. No surveys. No sensors on every machine. No member apps. Just real data from cameras you already have."

append_heading2 "$OP_ID" "What You Get"
append_bullet "$OP_ID" "Equipment utilization by zone - See which areas are packed vs. empty"
append_bullet "$OP_ID" "Peak usage patterns - Know when each zone is busiest"
append_bullet "$OP_ID" "Historical trends - Track changes over weeks and months"
append_bullet "$OP_ID" "Equipment ROI data - Justify purchases to investors/landlords"

append_heading2 "$OP_ID" "How It Works"
append_bullet "$OP_ID" "1. We connect to your existing IP cameras (or add a few if needed)"
append_bullet "$OP_ID" "2. Our edge device processes video locally—nothing leaves your gym"
append_bullet "$OP_ID" "3. You see utilization dashboards, updated daily"
append_paragraph "$OP_ID" "Privacy first: We detect zone occupancy, not individuals. No face recognition. No member tracking."

append_divider "$OP_ID"

append_heading2 "$OP_ID" "Packages"
append_paragraph "$OP_ID" "Connect: Already have IP cameras - \$359-\$718 setup + \$314-\$799/mo"
append_paragraph "$OP_ID" "Enhance: Some cameras, need more - \$2,838-\$6,586 setup + \$314-\$799/mo"
append_paragraph "$OP_ID" "Complete: No cameras or new build - \$5,900-\$45,834 setup + \$314-\$799/mo"
append_paragraph "$OP_ID" "Monthly pricing based on facility size. 12-month contracts."

append_heading2 "$OP_ID" "The ROI"
append_quote "$OP_ID" "One avoided bad equipment purchase pays for a year of service."
append_paragraph "$OP_ID" "Commercial treadmill: \$5,000-\$12,000 | Elliptical: \$4,000-\$8,000 | Cable machine: \$3,000-\$8,000 | Squat rack: \$1,500-\$4,000"
append_paragraph "$OP_ID" "If our data helps you buy one \$5K machine that members actually use instead of one that collects dust—that's your ROI."

append_heading2 "$OP_ID" "Works With Your Cameras"
append_paragraph "$OP_ID" "Ubiquiti UniFi, Meraki, Axis, Hikvision, Verkada, and any IP camera with RTSP support."

append_heading2 "$OP_ID" "Next Steps"
append_bullet "$OP_ID" "1. 15-min call — We learn about your facility"
append_bullet "$OP_ID" "2. Camera assessment — We check what you have"
append_bullet "$OP_ID" "3. Quote — Custom pricing for your setup"
append_bullet "$OP_ID" "4. Install — 1-2 hours, minimal disruption"

# ============================================
# 4. CREATE LANDING PAGE CONTENT
# ============================================
echo "4. Creating Landing Page Content page..."

LP_ID=$(create_page "$WIKI_PAGE_ID" "Landing Page Content")
echo "   Created Landing Page Content page: $LP_ID"

append_callout "$LP_ID" "🌐" "Content for the Uzzage landing page. Use with Carrd.co (\$19/yr) or Framer (free tier)."

append_heading1 "$LP_ID" "Hero Section"
append_heading2 "$LP_ID" "Know Which Equipment Your Members Actually Use"
append_paragraph "$LP_ID" "Equipment utilization analytics for gyms—powered by your existing security cameras."
append_paragraph "$LP_ID" "CTA: Book a Demo → Calendly link"

append_divider "$LP_ID"

append_heading1 "$LP_ID" "Problem Section"
append_heading3 "$LP_ID" "You're Buying Equipment Blind"
append_bullet "$LP_ID" "You guess which machines are popular"
append_bullet "$LP_ID" "You don't know what's gathering dust until members complain"
append_bullet "$LP_ID" "You can't justify equipment purchases to investors or landlords"
append_quote "$LP_ID" "Result: Wasted capital. Overcrowded zones. Frustrated members."

append_heading1 "$LP_ID" "Solution Section"
append_heading3 "$LP_ID" "Real Data From Cameras You Already Have"
append_paragraph "$LP_ID" "We connect to your existing security cameras and show you exactly which equipment gets used, when, and for how long."
append_paragraph "$LP_ID" "📊 Utilization by Zone - See which areas are packed vs. empty"
append_paragraph "$LP_ID" "⏰ Peak Patterns - Know when each zone is busiest"
append_paragraph "$LP_ID" "💰 Equipment ROI - Justify purchases with real data"

append_heading1 "$LP_ID" "How It Works"
append_heading3 "$LP_ID" "Up and Running in One Day"
append_bullet "$LP_ID" "1. We Connect — To your existing IP cameras (or add a few if needed)"
append_bullet "$LP_ID" "2. We Process Locally — Our edge device runs in your facility. Nothing leaves your gym."
append_bullet "$LP_ID" "3. You See — Utilization dashboards updated daily"

append_heading1 "$LP_ID" "Privacy Section"
append_heading3 "$LP_ID" "Privacy First. Always."
append_bullet "$LP_ID" "We detect zone occupancy, not individuals"
append_bullet "$LP_ID" "No face recognition"
append_bullet "$LP_ID" "No member tracking"
append_bullet "$LP_ID" "All processing happens on-site"

append_heading1 "$LP_ID" "Packages Section"
append_heading3 "$LP_ID" "Simple Pricing"
append_paragraph "$LP_ID" "Connect: Already have IP cameras - \$359 setup + \$314/mo"
append_paragraph "$LP_ID" "Enhance: Some cameras, need more - \$2,838 setup + \$314/mo"
append_paragraph "$LP_ID" "Complete: No cameras or new build - \$5,900 setup + \$314/mo"
append_paragraph "$LP_ID" "Monthly price varies by facility size. 12-month contracts."

append_heading1 "$LP_ID" "CTA Section"
append_heading3 "$LP_ID" "Ready to See What Your Members Actually Use?"
append_paragraph "$LP_ID" "15-minute call. No pressure. We'll assess your camera setup and give you a custom quote."
append_paragraph "$LP_ID" "CTA: Book a Demo"

append_divider "$LP_ID"

append_heading1 "$LP_ID" "Technical Notes"
append_paragraph "$LP_ID" "Recommended: Carrd.co (\$19/yr) + Calendly (free) + Google Analytics"
append_paragraph "$LP_ID" "Domain suggestions: uzzage.com, uzzage.io, getuzzage.com"
append_paragraph "$LP_ID" "Build time: 2-3 hours"

echo ""
echo "=== Wiki Sync Complete ==="
echo ""
echo "Created pages:"
echo "  - Company Overview: $OVERVIEW_ID"
echo "  - Financial Model: $FM_ID"
echo "  - Sales One-Pager: $OP_ID"
echo "  - Landing Page Content: $LP_ID"
echo ""
echo "View wiki: https://www.notion.so/2cf94de25d4d81f09890d7302b3365d4"
