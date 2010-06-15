# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class NostalgiaExtension < Radiant::Extension
  version "0.3"
  description "Easily track and administer not found pages"
  url "http://github.com/thinkcreate/radiant-nostalgia-extension"
  
  define_routes do |map|
    map.namespace :admin do |admin|
      admin.destroy_all_not_found_requests "/not_found_requests/destroy_all", :controller => 'not_found_requests', :action => 'destroy_all', :conditions => {:method => :delete}
    end
  end
  
  def activate
    FileNotFoundPage.send :include, Nostalgia::FileNotFoundPageExtensions
    NotFoundRequest.reset_at ||= Time.now
    Radiant::Config['nostalgia.rewrites_part_name'] ||= 'rewrites'
    
    if admin.respond_to?(:dashboard)
      admin.dashboard.index.add :extensions, 'not_found_requests'
    end
  end
  
  def deactivate
  end
  
end
