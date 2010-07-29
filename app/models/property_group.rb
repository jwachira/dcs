class PropertyGroup < ActiveRecord::Base
  has_many :property_sites
  
  def self.active
    scoped(:all, :conditions => {:active => true})
  end
end
