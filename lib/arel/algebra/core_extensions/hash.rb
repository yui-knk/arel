class Hash
  def bind(relation)
    Hash[map { |key, value|
      value = Hash === value ?
        Arel::Value.new(value, relation) :
        value.bind(relation)

      [key.bind(relation), value]
    }]
  end
end
