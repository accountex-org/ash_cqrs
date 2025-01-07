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
      validate_config_inclusion?: [
          type: :boolean,
          default: true,
          doc: "Whether or not to validate that the writable amd readonly domains are included in the configuration."
      ],
      writable_domain: [
        type: {:spark, Ash.Domain},
        doc: """
        The domain to use when creating, updating and deleting data.
        """,
        required: true
      ],
      readonly_domain: [
        type: {:spark, Ash.Domain},
        doc: """
        The domain to use when querying data.
        """,
        required: true
      ],
      events_bus: [
        type: {:spark, AshCqrs.EventBus},
        doc: """
        The event bus to use for processing events.
        """,
        required: true,
        default: :event_bus
      ],
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

  @impl true
  def verify(module, opts) do
    if Application.get_env(:ash, :validate_domain_config_inclusion?, true) &&
         Keyword.get(opts, :validate_config_inclusion?, true) && Code.ensure_loaded?(Mix.Project) do
      otp_app = Mix.Project.config()[:app]

      domains =
        Application.get_env(otp_app, :ash_domains, [])

      writable_domain = Keyword.get(opts, :writable_domain)
      readonly_domain = Keyword.get(opts, :readonly_domain)

      if writable_domain not in domains do
        IO.warn("""
        The writable domain #{inspect(writable_domain)} is not present in

            config :#{otp_app}, ash_domains: #{inspect(domains)}.


        To resolve this warning, do one of the following.

        1. Add the domain to your configured domain modules. The following snippet can be used.

            config :#{otp_app}, ash_domains: #{inspect(domains ++ [writable_domain])}

        2. Add the option `validate_config_inclusion?: false` to `use AshCqrs.Cqrs`

        3. Configure the writable domain not to warn, with `config :ash, :validate_domain_config_inclusion?, false`
        """)
      end

      if readonly_domain not in domains do
        IO.warn("""
        The read domain #{inspect(readonly_domain)} is not present in

            config :#{otp_app}, ash_domains: #{inspect(domains)}.


        To resolve this warning, do one of the following.

        1. Add the domain to your configured domain modules. The following snippet can be used.

            config :#{otp_app}, ash_domains: #{inspect(domains ++ [readonly_domain])}

        2. Add the option `validate_config_inclusion?: false` to `use AshCqrs.Cqrs`

        3. Configure the read-only domain not to warn, with `config :ash, :validate_domain_config_inclusion?, false`
        """)
      end
    end
  end


end
