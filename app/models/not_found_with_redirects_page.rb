class NotFoundWithRedirectsPage < FileNotFoundPage
  def cache?
    false
  end
  
  def mappings
    if redirects = render_part(:redirects)
      YAML.load(redirects).inject({}) do |m,(k,v)|
        m[clean_url(k)]=clean_url(v)
        m
      end
    else
      {}
    end
  end

  def process(request, response)
    super
    request_uri = clean_url(request.request_uri)
    if mappings.any? && location = mappings[request_uri]
      @response.headers["Location"] = location
      @response.body = <<-HTML
<html>
  <body>
    You are being <a href=\"#{CGI.escapeHTML(location)}\">redirected</a>.
  </body>
</html>
      HTML
      @response.status = 301
    end
  end
end