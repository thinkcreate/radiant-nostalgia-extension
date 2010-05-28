class NotFoundWithRedirectsPage < FileNotFoundPage
  def cache?
    false
  end

  def process(request, response)
    super
    request_uri = request.request_uri
    mapper = Nostalgia::Mapper.from_content(render_part(:redirects))
    if location = mapper.match(request_uri)
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