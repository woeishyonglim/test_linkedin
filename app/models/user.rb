class User < ActiveRecord::Base


  attr_accessible :age, :name
  validates_presence_of :name, :message => 'Missing required name field'
  validates_presence_of :age, :message => 'Missing required age field'

end
