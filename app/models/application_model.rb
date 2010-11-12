class ApplicationModel < ActiveRecord::Base
  self.abstract_class = true
  
  GENDER = ["Female", "Male"]
  
  ENROLLMENT_STATUS = ['On Waiting List', 'Enrolled', 'Suspended', 'Terminated']
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def self.active
    scoped(:conditions => {:active => true})
  end
  
  def self.create_or_update(options = {})
    if id = options.delete(:id)
      record = find_by_id(id) || new
      record.id = id
    elsif name = options[:name]
      record = find_by_name(name) || new
    end
    
    options.each_pair do |attr, value|
      record.send(attr.to_s + '=', value)
    end
    record.save!
  
    record
  end
end