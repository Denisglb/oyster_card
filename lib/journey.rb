class Journey

	attr_reader :entry_station
	attr_writer :exit_station

	PENALTY_FARE = 6
	FARE = 2

	def initialize(entry_station = nil, exit_station = nil)
		@entry_station = entry_station
		@exit_station = exit_station
	end

	def fare
		if incomplete? == true
			PENALTY_FARE
		else
		FARE
	end
	end

	def incomplete?
		@entry_station == nil || @exit_station == nil
	end
end