require "./Agents.rb"
require "./Coor3D.rb"

class ZombieSim
	INIT_HUMANS  = 100
	INIT_ZOMBIES = 1

	@@locations = Hash.new{|h, k| h[k] = Array.new}

	def addAgent(agent, coor)
		if coor.is_a? Coor3D
			@@locations[coor.to_s].push(agent)
		else
			@@locations[Coor3D.random.to_s].push(agent)
		end
	end

	def initialize(humans=INIT_HUMANS, zombies=INIT_ZOMBIES)
		humans.times  {addHuman}
		zombies.times {addZombie}
	end

	def addHuman(coor=nil)
		addAgent(Human.new, coor)
	end

	def addZombie(coor=nil)
		addAgent(Zombie.new, coor)
	end

	# This is the real meat of the simulation. All known agents get a chance to
	# move, then zombification kicks in.
	def step
		newLocations = Hash.new{|h, k| h[k] = Array.new}

		@@locations.each do |here,agents|
			zombiesHere = Array.new
			humansHere  = Array.new

			# sort into zombies/humans; will need to know in order
			# to figure out if we should try to make more zombies
			agents.each do |agent|
				if agent.is_a? Zombie
					zombiesHere.push(agent)
				elsif agent.is_a? Human
					humansHere.push(agent)
				end
			end

			numZombies = zombiesHere.length
			numHumans  = humansHere.length

			# If there are zombies and humans here, Fight!
			# Humans here have chance of becoming a zombie.
			if numZombies > 0 && numHumans > 0
				humansHere.each do |h|
					if ! h.fight(numZombies, numHumans)
						# Human lost. Remove it from existence...
						agents.delete(h)
						Human.rm
						# ... And add a zombie
						agents.push(Zombie.new)
					end
				end
			end

			# move all agents leftover here
			agents.each do |agent|
				newLoc = agent.moveFrom(here)
				newLocations[newLoc.to_s].push(agent)
			end
		end

		@@locations = newLocations.dup
	end

	def report
		Human.report
		Zombie.report
	end
end
