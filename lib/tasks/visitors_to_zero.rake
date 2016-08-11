desc "Set visitors count to zero"
task :visitors_to_zero => :environment do 
  Room.all.each do |room|
    room.update_attributes visitors_count: 0
  end
end
