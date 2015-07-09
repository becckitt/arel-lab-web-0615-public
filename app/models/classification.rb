class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.distinct
  end

  def self.longest_boat
    Boat.order("boats.length desc").limit(1)
  end

  def self.longest
    includes(:boats).where("boat_id IN (?)", self.longest_boat.pluck(:id))
  end


end
