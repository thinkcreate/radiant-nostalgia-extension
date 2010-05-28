class Regexp
  def self.from_glob(glob)
    # *.site1.nl  => /(.*)\.site1\.nl/
    # ?.site.nl   => /(.)\.site\.nl/
    # site.nl/[Aa]dmin   => /site\.nl\/([Aa])dmin/
    # glob.gsub!('\*','\\*')
    # glob = glob.gsub('\*','\\\\*')
    # Regexp.new(['^',Regexp.escape(glob).\
    #   gsub('\\*','(.*)').gsub('\\\\(.*)','\*').\
    #   gsub('\\?','(.)').\
    #   gsub('\\[','([').gsub('\\]','])'),'$'].join)
    Regexp.new(['^',Regexp.escape(glob).gsub('\\*','(.*)').\
      gsub('\\\(.*)','\*').\
      gsub('\\[','([').\
      gsub('\\]','])').\
      gsub('\\?','(.)'),'$'].join) 
  end
  # doe = lambda{|a| Regexp.new(['^',a.gsub('*','(.*)').gsub('\(.*)','\*'),'$'].join) }
end