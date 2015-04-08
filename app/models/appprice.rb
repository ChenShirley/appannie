class Appprice < ActiveRecord::Base
  attr_accessible :name, :price, :store, :fullrank_id
	belongs_to :fullrank
end
