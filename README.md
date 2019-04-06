# PNEB Example Run

The code shown here is an example of running PNEB on multiple GPUS
using the 2018 version of the AMBER Molecular Dynamics program. 

## Description of this run

This PNEB run uses 32 beads, 4 GPUs, and the following protocol
(adapted from "Energetic Preference of 8-oxodG Eversion Pathways in a DNA
Glycosylase" supplemental information protocol).

## Structures Used As Input

16 beads of 5JUS_GC_heat30.rst
16 beads of -75deg_rotation_restr_allbut59to62.rst (renamed to get rid of `-`)
[These are from `/home/kscopino/5JUS_GC/END_STRUCTURE_2_rot-75/` on cottontail]

## Description of Protocol
*(as seen in the mdinput files within this directory)*
"For PNEB and umbrella sampling simulations, an NVT ensemble was used. NEB forces were
calculated for all atoms of the solute and not the solvent. A simulated annealing path optimization
procedure was adapted from Mathews and Case 2006." - From Supplemental Info

Timestep is 1 fs. I think my simulations turn off SHAKE like in the tutorial,
which I believe to be fine because SHAKE is an approximation. So, this should be
valid, although it pins the timestep at a max of 1fs.

Spring force is 10 kcal/mol/A2, collision frequency is  
100 ps^-1 for first half of protocol, and spring force is 25 kcal/mol/A2
and collision frequency is 75 ps-1 for second half of protocol. Both 'halves'
have separate mdinput files.

## Steps of Protocol

First Half:
1) Heating from 0K to 330K over 80ps (50,000 timesteps)
2) Equilibration for 500ps at this temperature (500,000 timesteps)

Second Half:
1) Heating from 330K to 386K over 60ps (60,000 timesteps)
2) Equilibration at 386K for 220ps (220,000 timesteps)
3) Annealing (temp drop) from 386K to 330K over 100ps (100,000 timesteps)
4) Final Equilibration for 500ps (500,000 timesteps)

## Usage

To run the first stage, run `nohup sh pneb_first_half.sh &` on an 
MD-capable machine with 4 unused, sufficiently good GPUs. 

Check progress  or time to finish  by looking at any non-end-bead 
file within `inf` (Example: `cat pneb_bead_03_1st.inf`). 

Check relative energies of beads by looking at any file within `out` 
(Example: `cat pneb_bead_03_1st.inf`).

To run the second stage, run (after first stage completion)
`nohup sh pneb_second_half.sh &` on a MD-capable machine with 4
unused, sufficiently good GPUs.

To check progress, time to finish, or relative energies of beads,
follow the directions shown above except on beads with `2nd` at
the end of their name.
