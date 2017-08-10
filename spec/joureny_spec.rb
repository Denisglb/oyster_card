require 'journey'

describe 'Journey' do 
	
	 it "A journey has an entry station" do
 		 journey = Journey.new("victoria")
 		 expect(journey.entry_station).to eq "victoria"
 		end

	 it "A journey has been completed" do
 		 journey = Journey.new("Victoria", "TCR")
 		 expect(journey.incomplete?).to eq false
 		end

	 it "A fare has been deducted" do
 		 journey = Journey.new("Victoria", "TCR")
 		 std_fare = Journey::FARE
 		 expect(journey.fare).to eq std_fare
 		end

	 it "A pentaly fare is charged" do
 		 journey = Journey.new("victoria")
 		 pen = Journey::PENALTY_FARE
 		 expect(journey.fare).to eq pen
 		end
end
