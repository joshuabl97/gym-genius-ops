# Camera Coverage Requirements Calculator

A tool to help gym owners determine how many cameras are needed for Equipment Utilization (EU) zone monitoring.

---

## Quick Reference

| Gym Size | Zones | Cameras Needed | Monthly Cost |
|----------|-------|----------------|--------------|
| Small (<5,000 sq ft) | 3-5 | 2-3 | $500-600 |
| Medium (5,000-15,000 sq ft) | 5-8 | 3-4 | $600-700 |
| Large (15,000-30,000 sq ft) | 8-12 | 4-6 | $700-800 |
| Multi-Floor/Complex | 12+ | 6-8 | Custom |

---

## Step-by-Step Calculator

### Step 1: Identify Your Zones

Equipment Utilization tracks **zone occupancy**, not individual machines. Define zones based on equipment groupings:

| Zone Type | Typical Size | Example |
|-----------|--------------|---------|
| Cardio Area | 800-1,500 sq ft | Treadmills, bikes, ellipticals |
| Free Weights | 600-1,200 sq ft | Dumbbells, benches, racks |
| Weight Machines | 800-1,500 sq ft | Cable machines, leg press |
| Functional/CrossFit | 1,000-2,000 sq ft | Open floor, rigs, boxes |
| Stretching/Recovery | 400-800 sq ft | Mats, foam rollers |
| Group Fitness Room | 800-1,500 sq ft | Studio spaces |

**Your Zone Count:** ______ zones

---

### Step 2: Calculate Camera Coverage

Each wide-angle camera (2.8mm lens, 110° FOV) covers approximately:
- **Width:** 25-35 feet at 15 feet distance
- **Depth:** 30-50 feet effective range
- **Area:** ~800-1,200 sq ft per camera

#### Coverage Formula

```
Cameras Needed = (Total Gym Sq Ft / 1,000) + Zone Adjustment

Zone Adjustment:
  - Simple layout (open floor): +0
  - Moderate complexity (some walls): +1
  - Complex layout (multiple rooms): +2
```

#### Examples

| Gym | Sq Ft | Base | Adjustment | Total Cameras |
|-----|-------|------|------------|---------------|
| Boutique Studio | 3,000 | 3 | +0 (open) | 3 |
| Mid-size Gym | 10,000 | 10 | +1 (moderate) | 4* |
| Large Facility | 25,000 | 25 | +2 (complex) | 6* |

*Cameras with overlapping coverage can monitor multiple zones

---

### Step 3: Camera Placement Guidelines

#### Mounting Height
- **Optimal:** 9-12 feet
- **Minimum:** 8 feet (avoids tampering, captures full zone)
- **Maximum:** 14 feet (beyond this, detail decreases)

#### Placement Priorities
1. **Corners** - Maximum coverage with single camera
2. **Zone boundaries** - One camera can see 2-3 adjacent zones
3. **High-traffic areas** - Entrances to equipment areas
4. **Avoid** - Direct sunlight, mirrors (reflections), steam (near saunas)

#### Camera Angles
| Position | Best For |
|----------|----------|
| Corner mount (45°) | Open floor areas, cardio |
| Wall mount (straight) | Long rows of equipment |
| Ceiling mount (down) | Compact zones, functional areas |

---

### Step 4: Existing Camera Assessment

Many gyms already have security cameras. We can often use existing infrastructure:

#### Compatible Cameras
- IP cameras with RTSP streaming
- Resolution: 1080p minimum (4K preferred)
- Frame rate: 15+ FPS
- Wide-angle lens (2.8-4mm)

#### Assessment Checklist
- [ ] How many existing cameras?
- [ ] Camera locations (get floor plan if possible)
- [ ] Camera specs (brand, model, resolution)
- [ ] Network infrastructure (PoE switches, bandwidth)
- [ ] Current recording system (NVR/DVR)

#### Reuse Potential
| Existing Setup | Our Recommendation |
|----------------|-------------------|
| Modern IP cameras (2018+) | Likely reusable - just add edge compute |
| Older analog cameras | May need upgrade |
| No existing cameras | Full installation needed |

---

## Cost Estimation

### Hardware Costs (One-Time)

| Component | Cost Range | Notes |
|-----------|------------|-------|
| Edge Compute Box | $500-800 | Processes all cameras |
| New Camera (each) | $100-200 | If needed |
| PoE Switch | $50-150 | If needed |
| Installation | $200-400 | Professional mounting |
| **Total (typical)** | **$1,000-2,000** | Using existing cameras |
| **Total (new cameras)** | **$1,500-2,500** | 4 new cameras + compute |

### Monthly Costs

| Component | Cost Range |
|-----------|------------|
| Hardware Lease | $200-300/mo |
| Software Subscription | $300-500/mo |
| **Total** | **$500-800/mo** |

---

## Gym Size Templates

### Small Gym (< 5,000 sq ft)
```
Typical Setup:
- 2-3 cameras
- 3-5 zones (cardio, weights, functional)
- 1 edge compute box
- Monthly: $500-600
```

### Medium Gym (5,000 - 15,000 sq ft)
```
Typical Setup:
- 3-4 cameras
- 5-8 zones
- 1 edge compute box
- Monthly: $600-700
```

### Large Gym (15,000 - 30,000 sq ft)
```
Typical Setup:
- 4-6 cameras
- 8-12 zones
- 1 edge compute box
- Monthly: $700-800
```

### Multi-Location Chain
```
Per Location:
- Use templates above
- Volume discount available (10%+ for 3+ locations)
- Centralized dashboard included
```

---

## Sales Conversation Guide

### Discovery Questions
1. "How large is your facility in square feet?"
2. "Do you have existing security cameras?"
3. "How many distinct equipment areas would you want to track?"
4. "Is your layout open or divided into rooms?"

### Objection Handling

**"That's a lot of cameras"**
> "Actually, because we're tracking zones rather than individual machines, most gyms only need 3-4 cameras total. We can often use your existing security cameras."

**"We already have cameras"**
> "Perfect! In most cases we can connect directly to your existing system. We just add a small compute box that processes the feeds. No new cameras needed."

**"Seems complicated"**
> "The setup is actually straightforward - we mount one box, connect to your cameras, and you're getting data within days. We handle all the technical configuration."

---

## Appendix: Technical Specifications

### Recommended Camera Specs
| Spec | Minimum | Recommended |
|------|---------|-------------|
| Resolution | 1080p | 4K |
| Frame Rate | 15 FPS | 30 FPS |
| Lens | 4mm (90°) | 2.8mm (110°) |
| Protocol | RTSP | RTSP/ONVIF |
| Power | PoE | PoE+ |

### Edge Compute Requirements
| Spec | Requirement |
|------|-------------|
| Cameras Supported | Up to 8 |
| Processing | NVIDIA Jetson or equivalent |
| Network | Gigabit Ethernet |
| Power | 30-50W |

### Network Requirements
| Spec | Requirement |
|------|-------------|
| Bandwidth per camera | 4-8 Mbps |
| Internet upload | 10+ Mbps (for dashboard) |
| Local network | Gigabit recommended |

---

*Last Updated: 2024-12-22*
*Partner Agent - Gym Genius EU Sales*
