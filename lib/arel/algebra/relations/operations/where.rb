module Arel
  # TODO: Where should be renamed to Restriction
  class Where < Compound
    attributes :relation, :predicates
    deriving   :==
    requires   :restricting

    def initialize(relation, *predicates, &block)
      predicates = [yield(relation)] + predicates if block_given?
      @predicates = predicates.map { |p| p.bind(relation) }
      @relation   = relation
    end

    def wheres
      @wheres ||= relation.wheres + predicates
    end

    def optimized
      case relation
      when Where then collapse_restrictions
      else
        super
      end
    end

  private

    def collapse_restrictions
      collapsed = Where.new(relation.relation, relation.predicates + predicates)

      # That was easy
      return collapsed.optimized if engine_handles?(collapsed)

      # Swap the relations if needed
      if engine_handles?(self) && !engine_handles?(relation)
        Where.new(Where.new(relation.relation, predicates), relation.predicates).optimized
      else
        self
      end
    end

  end
end
