module Arel
  class Deletion < Compound
    attributes :relation
    deriving :initialize, :==

    def call
      engine.delete(self)
    end

    def engine_handles?(relation)
      true
    end
  end

  class Insert < Compound
    attributes :relation, :record
    deriving :==

    def initialize(relation, record)
      @relation, @record = relation, record.bind(relation)
    end

    def call
      engine.create(self)
    end

    def engine_handles?(relation)
      true
    end
  end

  class Update < Compound
    attributes :relation, :assignments
    deriving :==

    def initialize(relation, assignments)
      @relation, @assignments = relation, assignments.bind(relation)
    end

    def call
      engine.update(self)
    end

    def engine_handles?(relation)
      true
    end
  end
end
