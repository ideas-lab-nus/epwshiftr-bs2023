---
title: "Epwshiftr: incorporating open data of climate change prediction into building performance simulation for future adaptation and mitigation"
author:
  - name: Hongyuan Jia
    order: 1
    email: hongyuanjia@cqust.edu.cn
    affiliation: |
        Chongqing University of Science and Technology, Chongqing, 401331, People's Republic of China
  - name: Baisong Ning
    order: 2
    email: bsning@foxmail.com
    affiliation: |
        Zhengzhou University, Zhengzhou, Henan Province, 450001, People's Republic of China

submitted_by: "Dr. Hongyuan Jia (Chongqing University of Science and Technology)"
presenting:
    type: oral presnetation
    author: "Jia, Hongyuan (hongyuanjia@cqust.edu.cn)"

type: "A) Abstract for Paper - 2) Performance-driven design"
topics: "Weather & Climate adaptation"
keywords:
    - Climate change
    - CMIP6
    - EnergyPlus
    - EPW
    - GCM

date: "2022-10-29"
id: 556
---

# Aim and Approach

<!-- max 200 words -->

There exists a rich body of research and development on weather generators for
creating future weather data used for building performance simulation under
climate change. However, existing weather generators typically assume a single
GCM (General Circulation Model) or are only capable of considering GCMs from the
old CMIP (Coupled Model Intercomparison Project) projects published more than 10
years ago. This paper presents a free, open-source tool called ‘epwshiftr’ for
incorporating open data from the latest CMIP6 project into EnergyPlus Weather
(EPW) generation using the morphing method. The focus of this tool is to ease
the burden of the cumbersome process of data preparation as much as possible,
while to provide user-friendly and flexible ways to create future EPWs for
world-wide locations. It takes full advantage of data query and fetching
interfaces provided by the Earth System Grid Federation (ESGF) portals where
CMIP6 data are held. Epwshiftr is capable of processing multiple GCM outputs at
various spatial and temporal resolutions. Moreover, each module of epwshiftr
stores data in a standard data format, which allows exploring a considerably
broad pool of ready-to-use methods available for customized statistical
analysis. Most computational-intensive processes have been designed to run in
parallel for speed-up.


# Scientific Innovation and Relevance

<!-- max 200 words -->

Building energy simulation (BES) has become increasingly applied to assess
building performance under climate changes and to yield a more sustainable and
resilient design [1]. Multiple morphing-based weather-file modification tools
[2-4] have been developed over the decades to integrates climate change
predictions from CMIP projects that cover worldwide locations. Currently, the
CMIP project is in its sixth phase (CMIP6), which has developed new emission
scenarios that have the similar range as the CMIP5, but fill critical gaps for
intermediate forcing levels [5]. Currently, IPCC (Intergovernmental Panel on
Climate Change) has released the sixth climate assessment report (AR6) based on
the CMIP6. The use of outdated IPCC emission scenarios in existing research will
be unlikely to reasonably and effectively represent the climate impacts and
socioeconomic risks brought about by different policy options. Moreover, no such
tool is available which processes user-defined climate simulations in an
automated way and allows further statistical analysis. This paper bridges these
gaps.

# Preliminary Results and Conclusions

<!-- max 200 words -->

In this paper, we first introduce the concepts behind the tool, along with its
implementation. Then we demonstrate the capabilities of this package by creating
more than 120 future EPW files using 10 GCMs under the latest CMIP6 ‘ScenarioMIP’
emission scenarios (SSP126, SSP245, SSP370 and SSP585) for different time
periods based on the typical meteorological year (TMY) weather data. We examine
the future trend of climate variables that impact building performance under
different emission scenarios. We also discuss the typical strategies of climate
adaption and mitigation and their effects on building performance improvements.

# Main References

<!-- max 200 words -->

[1] Yassaghi, Hoque, An Overview of Climate Change and Building Energy:
Performance, Responses and Uncertainties, Buildings. 9 (2019) 166.
https://doi.org/10.3390/buildings9070166.

[2] L. Troup, Morphing Climate Data to Simulate Building Energy Consumption, in:
Proceedings of SimBuild 2016, Salt Lake City, UT, U.S., 2016: p. 8.

[3] M.F. Jentsch, A.S. Bahaj, P.A.B. James, Climate change future proofing of
buildings—Generation and assessment of building simulation weather files, Energy
and Buildings. 40 (2008) 2148–2168. https://doi.org/10/b4n9qc.

[4] R. Dickinson, B. Brannon, Generating future weather files for resilience, in:
Proceedings of PLEA 2016, Los Angeles, U.S., 2016: p. 6.

[5] B.C. O’Neill, C. Tebaldi, D.P. van Vuuren, V. Eyring, P. Friedlingstein, G.
Hurtt, R. Knutti, E. Kriegler, J.-F. Lamarque, J. Lowe, G.A. Meehl, R. Moss, K.
Riahi, B.M. Sanderson, The Scenario Model Intercomparison Project (ScenarioMIP)
for CMIP6, Geoscientific Model Development. 9 (2016) 3461–3482.
https://doi.org/10.5194/gmd-9-3461-2016.
