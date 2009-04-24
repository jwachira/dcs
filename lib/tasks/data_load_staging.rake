namespace :data do
  namespace :load do
    namespace :staging do
      
      task :all => %w(environment data:load:default:all) + %w().map{ |task| "data:load:staging:#{task}"}
      
    end #namespace :default
  end #namespace :load
end #namspace :date