class NotFoundWithRedirectsPage < FileNotFoundPage
  def cache?
    false
  end

  def mappings
    # [['/old','/new'],...]
    @mappings ||= begin
      lines = render_part(:redirects).split(%{\r\n})
      lines.inject([]){|res,line| res << line.split(/ +\=> +/, 2);res}
    end
  end
  
  def process(request, response)
    super
    request_uri = request.request_uri
    if location = find_location(request_uri)
      @response.headers["Location"] = location
      @response.body = <<-HTML
<html>
  <body>
    You are being <a href=\"#{CGI.escapeHTML(location)}\">redirected</a>.
  </body>
</html>
      HTML
      @response.status = 301
    # else
    #   nfr_url = if defined?(MultiSite)
    #               Page.current_site.url(request_uri)
    #             else
    #               request_uri
    #             end
    #   nfr_ref = request.referrer
    #   nfr = NotFoundRequest.find_or_initialize_by_url_and_referrer(nfr_url, nfr_ref)
    #   nfr.save
    end
  end
  
  
  def find_location(request_uri)
    captures = nil
    match = mappings.detect do |(from,to)|
      re = %r{^#{from}$}
      captures = request_uri.scan(re).flatten
      captures.any?
    end
    return nil unless match
    to = match.last
    build_path_from_captures(to, captures)
  end
  
  protected
  def build_path_from_captures(path, captures)
    captures.each_with_index do |cap, ix|
      path.gsub!("$#{ix+1}", cap)
    end
    path
  end
end