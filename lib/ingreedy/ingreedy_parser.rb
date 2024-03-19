require "parslet"

require_relative "amount_parser"
require_relative "rationalizer"
require_relative "root_parser"
require_relative "unit_variation_mapper"

module Ingreedy
  class Parser
    attr_reader :original_query

    Result = Struct.new(
      :amount,
      :unit,
      :container_amount,
      :container_unit,
      :ingredient,
      :descriptor,
      :original_query,
    )

    def initialize(original_query)
      @original_query = original_query
    end

    def parse
      result = Result.new
      result.original_query = original_query

      parslet = RootParser.new(original_query).parse

      result.amount = rationalize parslet[:amount]
      result.amount = [
        result.amount,
        rationalize(parslet[:amount_end]),
      ] if parslet[:amount_end]

      if parslet[:imprecise_amount]
        result.amount = parslet[:imprecise_amount].to_s
      end

      result.container_amount = rationalize(parslet[:container_amount])

      result.unit = convert_unit_variation_to_canonical(
        parslet[:unit].to_s,
      ) if parslet[:unit]

      result.container_unit = convert_unit_variation_to_canonical(
        parslet[:container_unit].to_s,
      ) if parslet[:container_unit]

      # Extract ingredient and descriptor
      ingredient, descriptor = parslet[:ingredient].to_s.lstrip.rstrip.split(/,\s*/, 2)

      # Assign the ingredient
      result.ingredient = ingredient

      # Only set the descriptor if one was found
      result.descriptor = descriptor if descriptor

      result
    end

    private

    def convert_unit_variation_to_canonical(unit_variation)
      UnitVariationMapper.unit_from_variation(unit_variation)
    end

    def rationalize(amount)
      return unless amount

      integer = amount[:integer_amount]
      integer &&= integer.to_s

      float = amount[:float_amount]
      float &&= float.to_s

      fraction = amount[:fraction_amount]
      fraction &&= fraction.to_s

      word = amount[:word_integer_amount]
      word &&= word.to_s

      Rationalizer.rationalize(
        integer: integer,
        float: float,
        fraction: fraction,
        word: word,
      )
    end
  end
end
