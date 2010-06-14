# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class NostalgiaExtension < Radiant::Extension
  version "0.3"
  description "Easily administer legacy urls"
  url "http://github.com/thinkcreate/radiant-nostalgia-extension"
  
  define_routes do |map|
    map.namespace :admin do |admin|
      admin.destroy_all_not_found_requests "/not_found_requests/destroy_all", :controller => 'not_found_requests', :action => 'destroy_all', :conditions => {:method => :delete}
    end
  end
  
  def activate
    # FileNotFoundPage.class_eval do
    #   # include Nostalgia::PageExtension
    #   
    #   
    # end
    FileNotFoundPage.send :include, Nostalgia::FileNotFoundPageExtensions
    NotFoundRequest.reset_at ||= Time.zone.now
    if admin.respond_to?(:dashboard)
      admin.dashboard.index.add :extensions, 'not_found_requests'
    end
  end
  
  def deactivate
  end
  
end
