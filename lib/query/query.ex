defmodule AshCqrs.Query do
  @moduledoc """
  An extension for creating a Query that will be applied to a read model.

  See the getting started guide for more.
  """

  @query %Spark.Dsl.Section{
    name: :query,
    schema: [
      name: [
        type: {:atom},
        doc: """
        The name of the query.
        """,
        default: []
      ],
      pre_check_identities_with: [
        type: {:spark, Ash.Domain},
        doc: "A domain to use to precheck generated identities. Required by certain data layers."
      ],
      query_handler: [
        type: {:spark, AshCqrs.Query.Handler},
        doc: "The handler for the query execution.",
        required: true
      ]
    ]
  }

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

  @sections [@query, @query_handler]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
