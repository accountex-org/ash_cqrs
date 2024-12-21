# Ash Cqrs

An implementation of the CQRS design pattern for the Ash framework.

## Features

### Data Sources
In a CQRS system, it is customery to have two separate data sources. 
- A normalized data repository with relationships for persisting information.
- A data repository optimized for querying information.

- [ ] DataSource DSL

### Commands 
In a CQRS system the commands are used for effectful changes to the system. They often represents your core business logic.
They usually involve some sort of persistence of the data but not necessarily.
- [ ] Command DSL
- [ ] Action command handlers
- [ ] Saga command handlers

### Queries 
In a CQRS system queries are used to obtain eventually consistent data. The persistent data is made consistent by processing the events queue.
- [ ] Query DSL
- [ ] Query handlers
- [ ] Query migrations generator
      
### Events
In a CQRS system events are used to update the optimized data repository. As the processing of events usually happens after the data as been previously persisted in the normalized repository aleady at this point the data is called eventually consistent. It is very important to keep the two data sources in sync, the events must have a prorper retry policy otherwise the queried information might be wrong.
- [ ] Events DSL
- [ ] Simple Events Bus
- [ ] Broadway Events Bus


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ash_cqrs` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ash_cqrs, "~> 0.1.0"}
  ]
end
```

The docs will be found at <https://hexdocs.pm/ash_cqrs> once published.

