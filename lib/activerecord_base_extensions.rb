class ActiveRecord::Base

  # known to break on any column named 'type'
  def self.create_or_update(options = {})
    id = options.delete(:id)
    record = find_by_id(id) || new
    record.id = id
  
    options.each_pair do |attr, value|
      record.send(attr.to_s + '=', value)
    end
    record.save!

    record
  end
  
end