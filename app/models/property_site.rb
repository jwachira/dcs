class PropertySite < ActiveRecord::Base
  belongs_to :property_group
  has_many :users
  
  def self.active
    scoped(:all, :conditions => {:active => true})
  end
end

Property_group -> Property_site 