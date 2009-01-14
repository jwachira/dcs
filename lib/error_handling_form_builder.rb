class ErrorHandlingFormBuilder < ActionView::Helpers::FormBuilder
	def initialize(object_name, object, something, options, proc)
		@object = object
		@cancel_url = options[:cancel_url]
		@object = object
		@proc = proc
		super
	end
	
	helpers = field_helpers +
		%w(date_select datetime_select collection_select) +
		%w(collection_select select time_zone_select) -
		%w(label hidden_field fields_for)
	helpers.each do |method_name|
		alias_method 'unwrapped_' + method_name, method_name
		define_method method_name do |field, *args|
			options = args.detect {|argument| argument.is_a?(Hash)} || {}
			wrap_field(field, options) do
				super
			end
		end
	end

	def text_field_before_type_cast(name, options = {})
		options[:value] ||= @object.send(name).to_s
		text_field(name,options)
	end

	def date_text_field(name,options = {})
		options[:class] = add_class_name(options[:class],'date')
		if options.delete(:date_picker)
			options[:class] = add_class_name(options[:class],'date-picker')
		end
		text_field_before_type_cast(name,options)
	end
	
	def time_text_field(method, options = {})
		options[:class] = add_class_name(options[:class],'time')
		text_field_before_type_cast(method, options)
	end
	
	# TOTALLY BORKED!
	# def time_select(method, options = {})
	# 	wrap_field(method) do
	# 		seperator = '<span class="timesep">:</span>'
	# 		@template.select_hour(method, options) + seperator + @template.select_minute(0, options) # TODO: select_minute currently defaults to 00 should be fixed
	# 	end
	# end
	#
	# for now, replacing it
	def time_select(method,options = {})
		time_text_field(method, options)
	end
	
	# <li>
	# 	<label>48 Mo. ASQ Completed</label>
	# 	<fieldset class="radio">
	# 		 <label><input type="radio" name="some_name" value="Yes" id="some_name"/>Yes</label>
	# 		 <label><input type="radio" name="some_name" value="No" id="some_name"/>No</label>
	# 	</fieldset>
	# </li>
	
	def boolean_field(method,options = {})
	  radio_group(method,[[true,'Yes'],[false,'No']])
	end

  def radio_group(method, options_array, options = {})
    wrap_field(method,options) do
			wrap_fields(:class => 'radio') do
			  options_array.map { |option|
				  "<label>#{unwrapped_radio_button(method, option[0])}#{option[1]}</label>"
				}.join("\n")
			end
		end
  end
	# <li><fieldset class="checkboxes nobg">
	# 	<legend>Other Funding Type(s):</legend>
	# 	<ul>
	# 	 <li><label><input type="checkbox" name="user[site_ids][]" value="1"/>Site 1</label></li>
	# 	 <li><label><input type="checkbox" name="user[site_ids][]" value="2"/>Site 2</label></li>
	# 	</ul>
	# </fieldset>
	# <input type="hidden" name="user[site_ids][]" value="" />
	# <input type="hidden" name="user[site_ids][]" value="3" />
	# <input type="hidden" name="user[site_ids][]" value="4" />
	# </li>
	def collection_checkboxes(method, collection, value_method, text_method, options = {}, html_options = {})
		currently_checked = object.send(method)
		provided_checkbox_values = []
		field_name = tag_name(method, options.merge(:multiple => true))
		
		
		if options[:columns]
			if options[:columns] == 2
				two_columns = true
				options.delete(:columns)
			else
				raise "Only `:columns => 2` is supported"
			end
		end
		
		wrap_field(method, options.merge(:type => :fieldset, :fieldset_class => "checkboxes#{options[:skip_indent] ? '' : ' indentLabelWidth'}")) do
			data = collection.collect{|obj| {:name => obj.send(text_method), :value => obj.send(value_method)} }
			provided_checkbox_values = data.map{|d| d[:value]}
	
			if two_columns
				group_size = (data.length / 2.0).ceil
			else
				group_size = data.length
			end
			html = ''
			first_list = true
			if data.length > 0
				data.in_groups_of(group_size,false).map do |objs|
					html << @template.content_tag(:ul, :class => two_columns ? "col two#{first_list ? ' left tight' : ' right'}" : nil) do
						first_list = false
						objs.map do |obj|
							# explicitly not using wrap_field() here, as the label is
							#    formed differently and we don't want error messages...
							@template.content_tag(:li) do
								@template.content_tag(:label) do
									# explicitly not using self.check_box here as we want only
									#    one hidden field generated and that would generate
									#    one for each checkbox
                    #raise currently_checked.inspect
									@template.check_box_tag(field_name, obj[:value], currently_checked.include?(obj[:value])) + h(obj[:name])
								end
							end
						end
					end
				end
			end
		
			# if none checked, make sure that the setter method still gets called.
			#    this is necessary because checkboxes don't send a value if unchecked
			html << @template.hidden_field_tag(field_name,'')
		
			# put hidden fields in for those currently selected values that didn't
			#    appear in the collection
			unless options.delete(:exclude_unprovided)
				(currently_checked - provided_checkbox_values).each do |other_id|
					html << @template.hidden_field_tag(field_name,other_id)
				end
			end
		
			html
		end
	end

	# <li><label for="subject">Subject <abbr title="Required Field">*</abbr></label>[[CONTENT]]</li>
	def wrap_field(field, options = {}, &proc)
		label_text = options[:label] || field.to_s.sub(/_ids?/,'').humanize.titlecase
		if options.delete(:required)
			label_text += '<abbr title="Required Field">*</abbr>'
		end
		
		error_message_span = ''
		if has_errors_on?(field)
			error_message_span = '<span><strong>Error:</strong> ' + error_message(field) + '</span>'
		end
		
		wrapper_class = options.delete(:wrapper_class) || ''
		wrapper_class += ' error message' if has_errors_on?(field)
		
		wrapped_content = yield
		if options.delete(:type) == :fieldset
			html = @template.content_tag('li',
				@template.content_tag('fieldset',
					@template.content_tag('legend', label_text) +
					error_message_span +
					wrapped_content,
					:class => options[:fieldset_class]
				),
				:class => has_errors_on?(field) ? 'error message' : ''
			)
			warn " -- #{html}"
		else
			label = label(field, label_text)
			html = @template.content_tag('li', label + error_message_span + wrapped_content, :class => wrapper_class)
		end
		html
	end
	
	def wrap_fields(options = {})
		html = %Q{<fieldset#{options[:class] ? ' class="' + options[:class].to_s + '"' : ''}">}
		
		if options[:label]
			html << "<legend>#{options[:label]}</legend>"
			# options.delete(:label)
		end
		
		html << "<ul#{options[:ul_class] ? ' class="' + options[:ul_class].to_s + '"' : ''}>#{yield}</ul></fieldset>"
		html
	end

	def tag_name(method_name, options = {})
		opts = options.stringify_keys
		# here we're using the same logic that the built-in helpers use
		ActionView::Helpers::InstanceTag.new(@object_name, method_name, self, @object).send(:add_default_name_and_id,opts)
		
		# ...and there might be a bug there.  if multiple is passed in as an 
		#    option, then the name should /always/, IMHO, end in []. Right now
		#    it seems to not pass it along if there is already a index.
		#    family[existing_guardian_attributes][1][need_ids][]
		if opts['multiple'] and opts['name'] !~ /\[\]$/
			opts['name'] += '[]'
		end
		
		opts['name']
	end
	
	def cancel(cancel_url = nil)
		cancel_url ||= @cancel_url
		if cancel_url
			close_fieldset + @template.content_tag(:div, :class => 'btn') do
				@template.link_to('Cancel', cancel_url, {:class => 'cancel'})
			end
		else
			''
		end
	end
	
	def submit(label = nil, options = {})
	  options[:class] ||= ''
	  options[:class] += ' btn save'
	  options[:title] = label
	  wrapper_class = options.delete(:wrapper_class) || ''
	  wrapper_class += ' btn'
		if self.object && self.object.respond_to?(:new_record?)
			label ||= self.object.new_record? ? 'Create' : 'Save'
		end
		close_fieldset + @template.content_tag(:div, :class => wrapper_class) do
			@template.submit_tag(label, options)
		end
	end
	
	def cancel_and_submit(options = {})
	  close_fieldset + '<div class="btnContainer clearfix">' + cancel(options[:cancel_url]) + submit(options[:submit_text], :wrapper_class => 'bold') + '</div>'
	end
	
	def close_fieldset
		if ! @form_closed
			@form_closed = true
			'</ul></fieldset>'
		else
			''
		end
	end
	
	private
	
	def add_class_name(current,new_class)
		if current
			"#{current} #{new_class}"
		else
			new_class
		end
	end

	def has_errors_on?(field)
		!object.nil? && object.respond_to?(:errors) && (!object.errors.on(field).blank? || !object.errors.on(field.to_s.sub(/_id(s)?$/) { $1 }).blank?)
	end
	
	def error_message(field)
		if has_errors_on?(field)
			errors = [object.errors.on(field),object.errors.on(field.to_s.sub(/_id(s)?$/) { $1 })].reject(&:nil?).flatten.uniq
			# raise 'error'
			errors.is_a?(Array) ? errors.to_sentence : errors
		else
			''
		end
	end
	
	def h(html)
		@template.html_escape(html)
	end
	
	require 'hpricot'
	ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
	  if html_tag =~ /<(input|textarea|select)/
	    error_class = 'error'
	    nodes = Hpricot(html_tag)
	    nodes.each_child { |node| node[:class] = node.classes.push(error_class).join(' ') unless !node.elem? || node[:type] == 'hidden' || node.classes.include?(error_class) }
	    nodes.to_html
	  else
	    html_tag
	  end
	end
end
ActionView::Base.default_form_builder = ErrorHandlingFormBuilder
