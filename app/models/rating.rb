class Rating < ActiveRecord::Base
  attr_accessible :name, :country, :average_current, :total_current, :average_all, :total_all, 
									:current1, :current2, :current3, :current4, :current5,
									:all1, :all2, :all3, :all4, :all5,
									:ranking_id
	belongs_to :ranking
end
