defmodule AshCqrs.Cqrs do
  @moduledoc """
  A CQRS definition allows you to configure your commands and queries,
  and holds instance-wide configuration.

  In example, you can define your commands, queries and event like so:

  ```elixir
  defmodule MyApp.MyCqrs do
    use AshCqrs.Cqrs

    commands do
      command CreatePost
      command UpdatePost
      command DeletePost
    end

    queries do
      query GetPost
    end

    events do
      event PostCreated
      event PostUpdated
      event PostDeleted
    end
  end
  ```
  """

  # TODO: Make sure all examples use the Blog/Post as examples and link back here

  @doc false
  @callback cqrs?() :: true

  use Spark.Dsl,
    default_extensions: [extensions: [AshCqrs.Dsl]],
    opt_schema: [
      events_bus: [
        type: {:spark, AshCqrs.EventBus},
        doc: """
        The event bus to use for processing events.
        """,
        required: true,
        default: :event_bus
      ],
      domain: [
        type: {:spark, Ash.Domain},
        doc: """
        The domain to use for creating, updating and deleting data.
        """,
        required: true
      ],
      query_domain: [
        type: {:spark, Ash.Domain},
        doc: """
        The domain to use for querying data.
        """,
        required: true
      ]
    ]

  @type t() :: module

  @impl Spark.Dsl
  def handle_opts(_opts) do
    quote do
      @behaviour AshCqrs.Cqrs

      @impl AshCqrs.Cqrs
      def cqrs?, do: true

    end
  end

   @impl Spark.Dsl
  def explain(dsl_state, _opts) do
    AshCqrs.Info.description(dsl_state)
  end

end
