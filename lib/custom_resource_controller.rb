module CustomResourceController
  def customized_resource_controller
    resource_controller

    self.class_eval do
      include DeleteAction
    end
  end
  
  # NOTE: not tested for deactivating resources that are themselves nested
  def boolean_resource_controller
    resource_controller :singleton
    helper_method :verb
    self.class_eval do
      include DeleteAction
      new_action.wants.html do
        if template_exists?
          render
        else
          render :template => 'defaults/activation/new'
        end
      end
      
      create.flash 'Successfully activated'
      destroy.flash 'Successfully deactivated'
      
      # usually destroy would redirect to the index
      destroy.wants.html { redirect_to object_url }
      
      # override create action to set active status to true, not actually create anything
      def create
        load_object
        before :create
        object.update_attributes(field => true)
        after :create
        set_flash :create
        response_for :create
      end
      
      # override destroy action to set active status to false, not actually destroy anything
      def destroy
        load_object
        before :destroy
        object.update_attributes(field => false)
        after :destroy
        set_flash :destroy
        response_for :destroy
      end
      
      private
      
      def object
        model.find(params[param])
      end
      
      def default_delete_template
        'defaults/activation/delete'
      end
      
      def param
        "#{object_name}_id"
      end
      
      def model_name
        object_name
      end
      
      def object_name
        self.type.to_s.match(/(\w+)::ActivationController$/)[1].singularize.underscore
      end
      
      def build_object
        object
      end
      
      def object_url
        smart_url(belongs_to, object)
      end
      
      def object_path
        smart_path(belongs_to, object)
      end
    end
  end
  
  module DeleteAction
    def self.included(klass)
      klass.class_eval do
        destroy.wants.html do
          redirect_to params[:_cancel_url]
        end
      end
    end
    
    def delete
      load_object
      if template_exists?
        render
      else
        render :template => default_delete_template
      end
    end
    
    def default_delete_template
      'defaults/delete'
    end
  end
end

