spark_locals_without_parens = [
  command: 4,
  event: 4,
  query: 4,
]

[
  import_deps: [:spark, :reactor],
  inputs: [
    "{mix,.formatter}.exs",
    "{config,lib,test,benchmarks,flames}/**/*.{ex,exs}"
  ],
  plugins: [Spark.Formatter],
  locals_without_parens: spark_locals_without_parens,
  export: [
    locals_without_parens: spark_locals_without_parens
  ]
]
