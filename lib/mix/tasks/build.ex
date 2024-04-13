defmodule Mix.Tasks.Build do
  @moduledoc "Creates a /public directory and places an HTML index file there"
  @shortdoc "Builds static HTML file"

  use Mix.Task

  @markup """
    <!DOCTYPE html>
    <html>
      <head></head>
      <body>hello world</body>
    </html>
  """

  @impl Mix.Task
  def run(_args) do
    Mix.shell().info("running build task")

    output_directory = Application.fetch_env!(:static_site, :output_directory)

    File.mkdir_p!(output_directory)
    output_directory |> Path.join("index.html") |> File.write!(@markup)
  end
end
