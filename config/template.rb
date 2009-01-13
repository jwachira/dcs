# initial setup

run "rm public/index.html"

# we need to run git :init before installing a plugin as a submodule
git :init
# we want these gems
# authlogic

# we want all these plugins...
# Userstamp
plugin 'userstamp',
  :git => 'git://github.com/delynn/userstamp.git', :submodule => true
plugin 'jrails',
  :svn => 'git://github.com/giraffesoft/resource_controller.git', :submodule => true
plugin 'resource_controller',
  :svn => 'http://svn.jamesgolick.com/resource_controller/tags/edge_compatible/stable', :submodule => true
plugin 'cross_site_sniper',
  :svn => 'http://xss.rubyforge.org/svn/cross_site_sniper/trunk'
# searchlogic
# resource_controller
# cross_site_sniper
# attribute_fu
# annotate_models
