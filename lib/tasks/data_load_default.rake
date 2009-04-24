namespace :data do
  namespace :load do
    namespace :default do
      # :all does not include users as that task may not be safe for all environments
      
      task :all => %w(assessment_types assessments roles ).map{ |task| "data:load:default:#{task}" } + %w()

      task :assessment_types  => :environment do
        puts '*** Loading Assessment Types ***'
        AssessmentType.create_or_update( :id => 1, :category => "Eco System",     :name => "Mountain Lake",    :subject => "Life Science",     :active => 1)
        AssessmentType.create_or_update( :id => 2, :category => "Force & Motion", :name => "Fire Road Rescue", :subject => "Physical Science", :active => 0)
      end
      
      task :assessments  => :environment do
        puts '*** Loading Assessments ***'
        description = "Brief description of the assessment, its goals, etc."
        Assessment.create_or_update( :id => 1, :name => "Mountain Lake (B)", :assessment_type_id => 1, :description => description, :swf_file_name => "ecomlembeddedCS3_v45.swf", :swf_file_path => "/flash/ecomlbench", :active => 1)
        Assessment.create_or_update( :id => 2, :name => "Mountain Lake (E)", :assessment_type_id => 1, :description => description, :swf_file_name => "ecomlembeddedCS3_v45.swf", :swf_file_path => "/flash/ecomlembed", :active => 1)
      end

      task :roles  => :environment do
        puts '*** Loading Roles ***'
        Role.create_or_update( :id => 1, :title => 'Admin'   )
        Role.create_or_update( :id => 2, :title => 'Teacher' )
        Role.create_or_update( :id => 3, :title => 'Student' )        
      end

    end #namespace :default
  end #namespace :load
end #namspace :data