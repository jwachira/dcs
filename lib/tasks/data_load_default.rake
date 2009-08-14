namespace :data do
  namespace :load do
    namespace :default do
      # :all does not include users as that task may not be safe for all environments
      
      task :all => %w().map{ |task| "data:load:default:#{task}" } + %w()

    end #namespace :default
  end #namespace :load
end #namspace :data
