ZombieSim
=========

Overview and assumptions
------------------------

This is a basic Zombie Apocalypse simulator. In it's simplest form, it's just a riff on the standard SIR model without the 'R'; zombies can't "recover" and become human again.

### Zombification

All humans are always susceptible to zombification if they're at the same location as a zombie. However their level of susceptibility can be altered.

A human's susceptibility can increase if they:
* have diminished energy from malnourishment;
* have diminished health from sustained injuries; or
* have no weapons.

Conversely, a human is less likely to succumb to zombification if the opposite of any the above criteria is true.

### World Properties

The world is 3-dimensional with the X and Z planes being ground level, and Y being vertical space (e.g., upper floors of buildings, subways, or catacombs). Points with a Y of 0 are at ground level. (X,Y,Z) coordinates are integer units, and each unit can hold a number of agents (zombies or humans).

### Iterations

The simulation is essentially turn-based. Future versions may be parallelized to allow for more continuous flow. Per step, the following actions, in this order, are executed:
1. Agents at a location are sorted into zombies and humans.
1. If there are both zombies and humans at this location, each human has some chance of becoming a zombie.
1. Agents move some amount (dependant on stats, etc.).

### Movement

Movement, similar to chances of zombification, is based on energy, health, inventory (big weapons equate to slower movement), and type of agent (zombies, by nature, will always move slower).

TODO
----
* Speed calculation method
* Survival chance calculation
* Weapons
* Food (food for humans, food for zombies)
* Location features (properties of specific locations)
* Humans with tendency to flock together
* Human "happiness" levels (chance of a sole human offing themselves)
* Human craftiness -- ability to build strongholds
