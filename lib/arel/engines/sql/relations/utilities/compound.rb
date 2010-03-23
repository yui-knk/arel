module Arel
  class Compound
    delegate :table, :table_sql, :root_engine, :to => :relation

    def build_query(*parts)
      parts.compact.join(" ")
    end
  end
end

