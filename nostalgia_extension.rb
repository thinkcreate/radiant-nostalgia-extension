# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

require %{nostalgia/regexp_ext}

class NostalgiaExtension < Radiant::Extension
  version "0.1"
  description "Easily administer legacy urls"
  url "http://yourwebsite.com/redirect"
  
  def activate
  end
  
  def deactivate
  end
  
end
