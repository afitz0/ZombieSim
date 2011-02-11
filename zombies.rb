#!/opt/local/bin/ruby1.9 -w

require './ZombieSim.rb'

# Basic SIR: for some number of iterations, move agents randomly. 
# If human and zombie are on same coor, some chance Human becomes zombie.

# -- NOTE --
# Without zombie decomposition, all humans will eventually become zombies,
# regardless of initial number of zombies.
# ----------

z = ZombieSim.new(20, 10)

10.times do |i|
	p "---> Step #{i}"
	z.step
end

z.report
