module FormHelper
	def error_handling_form_for(record_or_name_or_array, *args, &proc)
		raise ArgumentError, "Missing block" unless block_given?

		options = args.extract_options! || {}
		options[:builder] = ErrorHandlingFormBuilder
		object_name = ''
		case record_or_name_or_array
		when String, Symbol
			object_name = record_or_name_or_array
		when Array
			object = record_or_name_or_array.last
			object_name = ActionController::RecordIdentifier.singular_class_name(object)
			apply_form_for_options!(record_or_name_or_array, options)
			args.unshift object
		else
			object = record_or_name_or_array
			object_name = ActionController::RecordIdentifier.singular_class_name(object)
			apply_form_for_options!([object], options)
			args.unshift object
		end
		
		if object.respond_to?(:errors) && ! object.errors.empty? && object.errors.on_base
			error_message = "<div class='pager error'><p>Errors were found</p>"
			error_message += '<ul>'
			[*object.errors.on_base].each do |error|
				error_message += "<li>#{error}</li>"
			end
			error_message += '</ul>'
			error_message += '</div>'
		else
			error_message = ''
		end
		content_for(:form_error_message, error_message)
		options[:html] ||= {}
		#TODO this should be handled differently - a normal form_for doesn't need :html => {:class => 'class'}, it works without the :html =>, but this currently does not -- also this should prob be merged with thos passed in...
		if options[:html][:class].blank?
			options[:html][:class] = ''
		end
		options[:html][:class] += ' wei'
		options[:cancel_url] ||= params[:success_redirect] || params[:_cancel_url] || request.referer || options[:url]
		concat(
			error_message +
			form_tag(options.delete(:url) || {}, options.delete(:html)) +
			"<fieldset><ul#{options[:ul_class] ? ' class="' + options[:ul_class].to_s + '"' : ''}>"
		)
		
		fields_for(object_name, *(args << options), &proc)
		
		additional_hidden_fields = ''
		
		success_redirect = params[:success_redirect] || options[:success_redirect] || (params[:_redirect_on] && params[:_redirect_on][:success])
		
		if success_redirect
			additional_hidden_fields = hidden_field_tag('_redirect_on[success]',success_redirect)
		end
		
		if options[:cancel_url]
			additional_hidden_fields << hidden_field_tag('_cancel_url', options[:cancel_url])
		end
		
		concat(additional_hidden_fields +'</form>')
	end
	
	def wrap_fields(options, &block)
		concat("<fieldset><legend>Emergency Contacts</legend> #{capture(&block)} AFTER</fieldset>")
	end
end
