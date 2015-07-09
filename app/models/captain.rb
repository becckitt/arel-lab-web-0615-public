class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})

  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboatists
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seamen
    Captain.where("id IN (?)", Captain.sailors.pluck(:id) & Captain.motorboatists.pluck(:id))
  end

  def self.non_sailors
    Captain.where.not("id IN (?)", Captain.sailors.pluck(:id))
  end


end
