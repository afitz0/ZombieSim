ZombieSim
=========

This is a basic Zombie Apocalypse simulator. In it's simplest form, it's just a riff on the standard agent-based SIR model, just without the 'R': zombies can't "recover" and become human again. It'll become more complicated as time goes on, but my real interest in doing this is to learn Ruby. And to make a Zombie Simulator.

What follows is a discussion of what my assumptions and thoughts are for the functionality of the simulator. How do the agents behave, what does the terrain look like, how do the agents interact with each other and the terrain, etc. Some of the assumptions and features outlined in the prose below may not be implemented yet (see the TODO at the bottom to get an idea for what the missing features are).

Feel free to contact me with suggestions.

Details and Assumptions
------------------------

### Zombification and Zombies

All humans are always susceptible to zombification if they're at the same location as a zombie. However their level of susceptibility can be altered depending on current stats. Susceptibility can never be 0%; no human is ever immune to zombification.

A human agent's susceptibility can increase if they:
* have diminished energy from malnourishment;
* have diminished health from sustained injuries; or
* have no weapons.

Conversely, a human is less likely to succumb to zombification if the opposite of any these criteria is true.

When a human and zombie are at the same location, they must "fight." If the human loses the fight, they immediately become a zombie (or, more specifically, they disappear and a new zombie is created in their place). Newly created zombies have no health and are thus doomed to much slower movement than their previously living selves.

Zombies cannot carry weapons -- they _are_ the weapon. If the zombie was converted from a human who was carrying weapons, they do not inherit those weapons. Instead, the weapons are dropped on-location and become free game for other humans.

### The World

The world is 3-dimensional with the X and Z planes being ground level, and Y being vertical space (e.g., upper floors of buildings, subways, or catacombs). Points with a Y of 0 are at ground level. (X,Y,Z) coordinates are integer units, and each unit can hold a number of agents (zombies or humans).

### Movement

Movement, similar to chances of zombification, is based on energy, health, inventory (big weapons equate to slower movement), and type of agent (zombies, by nature, will always move slower). Movement can be in any direction along the X/Z plane ("ground level"). If the agent is at a location with a feature that permits vertical movement (staircase, ladder, elevator, rocket ship), then they can move in that direction as well.

### Energy

Every agent has some amount of energy at their creation (see MAX\_ENERGY in Agents.rb) and can expend it by engaging in certain activities. Agents require energy to survive and will perish if all energy is expended. Zombies regain energy by eating humans, while humans regain energy by eating food.

As of yet, there is no regulation of energy usage: the more energy an agent has, the farther it will move, thus using more energy. So far, movement is the only action that expends energy, though a human-zombie fight will probably require energy in the future.

### Iterations

The simulation is essentially turn-based. Future versions may be parallelized to allow for more continuous flow. Per step, the following actions, in this order, are executed:

1. Agents at a location are sorted into zombies and humans.
2. If there are both zombies and humans at this location, each human has some chance of becoming a zombie.
3. Agents move some amount (dependant on stats, etc.).

TODO
----
* Movement to occur at "ground level" instead of having agents floating around at random in a 3D space.
* Survival chance calculation
* Weapons
* Food (food for humans, food for zombies)
* Location features (properties of specific locations)
* Humans with tendency to flock together
* Human "happiness" levels (chance of a sole human offing themselves)
* Human craftiness -- ability to build strongholds
