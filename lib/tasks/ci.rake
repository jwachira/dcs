begin
  require 'metric_fu'
  
  MetricFu::Configuration.run do |config|
    build_time = DateTime.now.to_s        
    ci_path = "/var/www/apps/integrity/public/metrics"
    
    config.output_directory = File.exists?(ci_path) ? ci_path : "tmp/mf"
    
    config.metrics  = [:churn, :saikuro, :stats, :flay, :flog, :reek, :roodi]
    config.flay     = { :dirs_to_flay => ['app', 'lib']  } 
    config.flog     = { :dirs_to_flog => ['app', 'lib']  }
    config.reek     = { :dirs_to_reek => ['app', 'lib']  }
    config.roodi    = { :dirs_to_roodi => ['app', 'lib'] }
    config.saikuro  = { :output_directory => 'tmp/metric_fu/output', 
                        :input_directory => ['app', 'lib'],
                        :cyclo => "",
                        :filter_cyclo => "0",
                        :warn_cyclo => "5",
                        :error_cyclo => "7",
                        :formater => "text"} #this needs to be set to "text"
    config.churn    = { :start_date => "1 year ago", :minimum_churn_count => 10}
    config.rcov     = { :test_files => ['test/**/*_test.rb', 
                                        'spec/**/*_spec.rb'],
                        :rcov_opts => ["--sort coverage", 
                                       "--no-html", 
                                       "--text-coverage",
                                       "--no-color",
                                       "--profile",
                                       "--rails",
                                       "--exclude /gems/,/Library/,spec"]}
   config.graphs = []
  end
rescue LoadError
  warn "to use metric fu, `sudo gem install jscruggs-metric_fu`"
end

task :cruise => ["ci:all"]


namespace :ci do
  desc "full build with metrics"
  task :all => [:run_tests, "metrics:all", :cucumber]
  # task :all => [:run_tests]

  task :environment do
    p "Build started => #{DateTime.now}"
    sh "git submodule update --init"
    if ci_host?
      ENV["PATH"] = "/usr/local/ruby-enterprise/bin:#{ENV["PATH"]}"
      sh "cp config/database.yml.sample config/database.yml"
      p "database.yml created"
    end
  end
  
  task :install_gems do
    p "installing gems"
    sh "sudo rake gems:install"
    sh "sudo rake gems:install RAILS_ENV=test"
    sh "sudo rake gems:install RAILS_ENV=cucumber"
    p "done installing gems"
  end
  
  task :run_tests => [:environment, :install_gems, "db:create:all", "db:migrate", "db:test:prepare"] do
    p "ready to run tests"
    Rake::Task["test"].invoke
    p "done tests"
  end
    
  def ci_host?
    ENV["HOST"].nil? || ( ENV["HOST"].match(/ci/) && ENV["HOST"].match(/ruby/) )    
  end
end #namspace :ci

