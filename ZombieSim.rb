require "./Agents.rb"
require "./Coor3D.rb"

module ZombieSim
	INIT_HUMANS  = 100
	INIT_ZOMBIES = 1

	@@locations = Hash.new{|h, k| h[k] = Array.new}

	def ZombieSim.addAgent(agent, coor)
		if coor.is_a? Coor3D
			@@locations[coor].push agent
		else
			@@locations[Coor3D.random].push agent
		end
	end

	def ZombieSim.initSim(humans=INIT_HUMANS, zombies=INIT_ZOMBIES)
		humans.times  {addHuman}
		zombies.times {addZombie}
	end

	def ZombieSim.addHuman(coor=nil)
		addAgent(Human.new, coor)
	end

	def ZombieSim.addZombie(coor=nil)
		addAgent(Zombie.new, coor)
	end

	def ZombieSim.step
		newLocations = Hash.new{|h, k| h[k] = Array.new}

		@@locations.each do |loc,agents|
			zombieHere = false

			# move all agents at this location
			agents.each do |agent|
				# XXX This code has the potential to move a single agent multiple times
				# XXX That shouldn't be allowed!
				newLoc = agent.moveFrom(loc)
				if newLoc != loc
					newLocations[newLoc].push(agent)
				end

				if agent.is_a? Zombie
					zombieHere = true
				end
			end

			if zombieHere
				# humans here have chance of becoming a zombie
				p "humans might fall!"
			end
		end

		@@locations.replace(newLocations)
	end

	def ZombieSim.report
		Human.report
		Zombie.report
	end
end
