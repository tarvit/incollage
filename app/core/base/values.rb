require 'json'
class Json < Virtus::Attribute
  def coerce(value)
    hash = value.is_a?(::Hash) ? value : JSON.parse(value)
    HashWithIndifferentAccess[hash]
  end
end
