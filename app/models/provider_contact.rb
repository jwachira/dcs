class ProviderContact < ApplicationModel
  belongs_to :provider
  validates_presence_of :provider
  validates_presence_of :first_name, :last_name, :title, :phone_number
end
