defmodule Journal.Writer do


  def get_date do
    DateTime.utc_now
    |> DateTime.shift_zone!(Application.get_env(:journal, :timezone))
    |> Date.to_string
  end

  def get_name do
    get_date()
  end

  def get_journal_root_path do
    Application.get_env(:journal, :journal_root_dir)
    |> Path.expand()
  end

  def get_today_path do
    get_journal_root_path()
    |> Path.join(get_name())
  end

  def get_time do
    DateTime.utc_now
    |> DateTime.shift_zone!(Application.get_env(:journal, :timezone))
    |> DateTime.to_time
    |> Time.truncate(:second)
    |> Time.to_string
  end

  def get_entry_prefix(delim) do
    "[#{get_time()}]" <> delim
  end

  def build_entry(content) do
    get_entry_prefix(" - ") <> content <> "\n"
  end

  def write_today(content) do
    get_journal_root_path() |> File.mkdir_p
    get_today_path() |> File.write(build_entry(content), [:append])
  end
end
