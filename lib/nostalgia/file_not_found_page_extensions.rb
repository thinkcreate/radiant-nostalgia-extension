module Nostalgia::FileNotFoundPageExtensions
  def self.included(base)
    base.class_eval {
      alias_method_chain :process, :stats
    }
  end
  
  def process_with_stats(request,response)
    nfr_ref, nfr_uri = request.referrer, request.request_uri
    
    nfr_url = if defined?(MultiSite)
                Page.current_site.url(nfr_uri)
              else
                nfr_uri
              end
    nfr = NotFoundRequest.find_or_initialize_by_url_and_referrer(nfr_url, nfr_ref)
    nfr.save
    
    process_without_stats(request, response)
  end
end
