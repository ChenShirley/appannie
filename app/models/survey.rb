class Survey < ActiveRecord::Base
	validates_presence_of :age, :gender, :income, :involvement1, :involvement2, :involvement3, :rf1, :rf2, :rf3, :rf4, :rf5, :rf6, :rf7
  validates :age, numericality: { only_integer: true }
  attr_accessible :esearch, :regulatoryfocus,
									:age, :gender, :income,
									:involvement1, :involvement2, :involvement3, 
									:rf1, :rf2, :rf3, :rf4, :rf5, :rf6, :rf7,
									:endtime
end
