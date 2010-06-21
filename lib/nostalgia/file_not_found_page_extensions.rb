module Nostalgia::FileNotFoundPageExtensions
  def self.included(base)
    base.class_eval {
      alias_method_chain :process, :stats
    }
  end
  
  def process_with_stats(request,response)
    process_without_stats(request, response)
    
    @not_found_request = not_found_request(request.request_uri, request.referer)
    @not_found_request.increment_count_created!
  end
  
  
  private
  
  def not_found_request(uri, ref)
    url = if defined?(MultiSite)
            Page.current_site.url(uri)
          else
            uri
          end
    NotFoundRequest.find_or_initialize_by_url_and_referrer(url, ref)
  end
end
