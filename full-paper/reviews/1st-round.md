---
title: "Epwshiftr: incorporating open data of climate change prediction into building performance simulation for future adaptation and mitigation"

result: "accepted with minor revisions"

date: "2023-05-21"
id: 1612
---

Overview of Reviews
----------------------------------------

Review 1
========

Evaluation of the Contribution
------------------------------
Suitability and relevance      : + ) in good agreement
Novelty                        : + ) in good agreement
Methodology and technical merit: + ) in good agreement
Format and language            : + ) in good agreement

General recommendation: Accept as is
Best Paper Award      : Yes
Type of presentation  : Oral presentation

Comments for the Authors
------------------------
This paper developed a free open-source future weather generator epwshiftr,
which can generate future weather data for 11 meteorological variables.

Review 2
========

Evaluation of the Contribution
------------------------------
Suitability and relevance      : + + ) clearly and completely in agreement
Novelty                        : + ) in good agreement
Methodology and technical merit: + ) in good agreement
Format and language            : + ) in good agreement

General recommendation: Major revision
Best Paper Award      : No
Type of presentation  : Oral presentation

Comments for the Authors
------------------------
Epwshiftr appears to be a useful tool for modelers investigating likely
performance of buildings in the future.

The format and writing quality of the paper is acceptable once minor errors are
corrected. I noticed as least one incorrect word usage ("further" instead of
"future"). Please carefully proof-read the paper.

However, the figures should be enlarged and clarified. Figures 1 and 2 are both
unreadable in a printout of the paper. They are not particularly clear even
when viewing the PDF at high magnification. The listings are fuzzy; listings 4
and 5 are also too small. The manuscript is significantly shorter than the 8
page limit, so space is available to enlarge and clarify these items.

You refer to the morphing method as "reliable". I am not sure there is
consensus on that. Morphing modifies individual weather items independently and
may not preserve physically realistic relationships among them. Further,
unconstrained morphing can produce physically impossible values, such as wet
bulb temperature greater than dry bulb temperature. Finally, morphing does not
capture time-dependent effects such as concentration of temperature increases in
nighttime hours. You should amplify your discussion of how morphing is
implemented. Further, you should comment on the adaptability of your framework
to support alternative extrapolation algorithms.

In addition, it would be helpful to provide at least general information on
testing and validation. Have simulation results been compared for studies done
with epwshiftr weather data to those conducted with some of the other future
weather methods you cite? Is the NetCDF data reliable and what happens when it
is not? Can potential users be confident that epwshiftr will "do the job"? 
