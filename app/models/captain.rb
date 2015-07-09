class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: :classifications).where(classifications: { name: 'Catamaran' })
  end

  def self.sailors
    self.joins(boats: :classifications).where(classifications: { name: 'Sailboat' }).uniq
  end

  def self.talented_seamen
    self.joins(boats: :classifications).where('classifications.name = "Sailboat" OR classifications.name = "Motorboat"').group('classifications.id')
  end

  def self.non_sailors
    sailboat_captain_ids = self.sailors.pluck(:id)
    self.where.not(id: sailboat_captain_ids)
  end

end


