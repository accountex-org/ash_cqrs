<!--
This file was generated by Spark. Do not edit it by hand.
-->
# DSL: AshCqrs.Commands.Command

An extension for defining a command to be processed by the CQRS system.



## commands
Configures what commands will be available in the system.

Commands are used for effectful changes to the system.
They usually involve some sort of persistence of the data but not necessarily.

#### Example

```elixir
commands do
command do
name: :create_post,
description: "Creates a new post.",
handler: CreatePostAction,
args: [
post: :post_argument
]
end
end
```


### Nested DSLs
 * [command](#commands-command)





## commands.command
```elixir
command name, description, handler, args
```


Defines a new command and its handler.






### Arguments

| Name | Type | Default | Docs |
|------|------|---------|------|
| [`name`](#commands-command-name){: #commands-command-name .spark-required} | `atom` |  | A unique atom identifying the name of the command. |
| [`description`](#commands-command-description){: #commands-command-description } | `String.t` |  | An optional description for the command. |
| [`handler`](#commands-command-handler){: #commands-command-handler } | `Ash.Resource.Actions.Action \| Ash.Reactor` |  | Either a simple `Ash.Resource.Actions.Action` or an `Ash.Reactor` for more complex logic handling. |
| [`args`](#commands-command-args){: #commands-command-args } | `list(module)` |  | The arguments for the command execution. |






### Introspection

Target: `AshCqrs.Commands.Command`





<style type="text/css">.spark-required::after { content: "*"; color: red !important; }</style>
