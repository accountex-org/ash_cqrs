defmodule AshCqrs.QueryHandler do
  @moduledoc """
  An extension for creating a query. See the getting started guide for more.
  """

  @query_handler %Spark.Dsl.Section{
    name: :query_handler,
    schema: [
      handler_for: [
        type: {:spark, AshCqrs.Query},
        doc: """
        The `AshCqrs.Query` to be handled.
        """,
        require: true
      ],
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
