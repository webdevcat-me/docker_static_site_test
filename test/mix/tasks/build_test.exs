defmodule Mix.Tasks.BuildTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  setup do
    output_dir = "public"
    original = Application.fetch_env!(:static_site, :output_directory)
    Application.put_env(:static_site, :output_directory, output_dir)

    on_exit(fn ->
      Application.put_env(:static_site, :output_directory, original)
      File.rm_rf!(tmp_path())
    end)

    [output_dir: output_dir]
  end

  test "creates output file", %{output_dir: output_dir} do
    File.mkdir_p!(tmp_path("build"))
    File.cd!(tmp_path("build"))

    File.write("index.html", """
    <!-- Auto-generated fixture -->
    <!DOCTYPE html>
    <html>
      <body>hello world</body>
    </html>
    """)

    capture_io(fn -> Mix.Tasks.Build.run([]) end)

    assert File.exists?(Path.join(output_dir, "index.html"))

    File.cd!(__DIR__)
  end

  defp tmp_path, do: Path.expand("../tmp", __DIR__)
  defp tmp_path(extension), do: Path.join(tmp_path(), extension)
end
