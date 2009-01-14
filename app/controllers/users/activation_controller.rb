class Users::ActivationController < ApplicationController
  boolean_resource_controller

	def field
		:admin
	end
	
	def verb
		'make administrator'
	end
end