class Station
	 attr_reader :name, :zone

	 def initialize(name, zone)
 	  @zone = zone.to_i
 	  @name = name
 	end

	# def station_list
	# data = 
	# {station: @name, zone: @zone}
	# end
end
