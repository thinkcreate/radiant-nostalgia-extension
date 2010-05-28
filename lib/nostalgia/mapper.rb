class Nostalgia::Mapper < Struct.new(:mappings)
  def self.from_content(content)
    mappings = YAML.load(content)
    new(mappings)
  rescue
    nil
  end
  
  def match(old_url)
    captures = nil
    match = mappings.detect do |mapping|
      from, to = mapping.to_a.flatten
      captures = old_url.scan(Regexp.from_glob(from)).flatten
      !captures.empty?
    end
    return nil unless match
    to = match.values.first
    replace_captures(to, captures)
    to
  end
  
  protected
    def replace_captures(s,captures)
      captures.each_with_index do |cap, ix|
        s.gsub!(%{$#{ix+1}}, cap)
      end
      s
    end
end