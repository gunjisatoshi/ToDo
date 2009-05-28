class Category < ActiveRecord::Base
  validates_length_of :category, :within => 1..20
  validates_uniqueness_of :category, :message => "already exists"
end
