defmodule AshCqrs.QueryHandler do
  @moduledoc """
  An extension for creating a QueryHandler that will be applied to a read model.

  See the getting started guide for more.
  """
  @query_handler %Spark.Dsl.Section{
    name: :query_handler,
    schema: [
      handle_with: [
        type: {:spark, Ash.Resource.Actions.Action},
        doc: "The `Ash.Resource.Actions.Action` used to handle the query.",
        required: true
      ]
    ]
  }

  @sections [@query_handler]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
