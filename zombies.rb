
require "./Agents.rb"
# Init living humans, random locations

# Init zombies, random locations

# Basic SIR: for some number of iterations, move agents randomly. 
# If human and zombie are on same coor, some chance Human becomes zombie.
# Without zombie decomposition, all humans will eventually become zombies,
# regardless of initial number of zombies.

h = Human.new(Coor3D.new(0,0,0))

for i in 1..1000 do
	
end
