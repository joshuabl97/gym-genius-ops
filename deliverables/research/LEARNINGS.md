# Research Agent Learnings

Knowledge accumulated across research tasks. Update this after each task.

---

## EU Validation Insights
<!-- Do gyms care about utilization? What metrics matter? -->

## Customer Discovery Notes
<!-- Insights from gym owner conversations -->

## EU Competitive Intelligence
<!-- IoT sensors, Mindbody analytics, manual counting -->

## EU Pricing Research
<!-- Price sensitivity, willingness to pay -->

### Hardware BOM Validation (Dec 2024)
**Edge Compute:**
- Jetson Orin Nano Super: $249 (67 TOPS) - sufficient for 60-90 camera streams at 1 FPS
- Jetson Orin NX: ~$1,000 (100+ TOPS) - only needed for Enterprise Full Install (75+ cameras)
- Original model had Orin NX at $249 (error - that was Nano Super pricing)

**Cameras (validated pricing):**
- Ubiquiti AI 360: $419 (360° fisheye, sleek profile, AI-ready) - DEFAULT
- Uniview IPC314SB: $150 (low-profile mini dome, NDAA compliant) - discrete option
- Amcrest IP4M-1055E: $100 (compact turret) - budget discrete option
- Camera density: 1 camera per 600 sqft for equipment zone coverage
- Note: Hikvision/Reolink cameras are bulky - switched to Ubiquiti for aesthetics

**Key Insight:** At 1 FPS sampling (vs 30 FPS), compute requirements drop 30x, making Orin Nano Super viable for most deployments

## WT Research (Secondary)
<!-- Workout tracking market research -->

## Effective Research Approaches
<!-- Research methodologies that worked well -->

## Resources Found
<!-- Useful links, reports, data sources -->

## Things to Avoid
<!-- Approaches that didn't work -->
