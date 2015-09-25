class Review < ActiveRecord::Base
  attr_accessible :name, :star, :title, :author, :content, :date, :country, :version
end
