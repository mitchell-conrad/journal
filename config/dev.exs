import Config
config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase
config :journal, 
  timezone: System.fetch_env!("JOURNAL_TZ"),
  journal_root_dir: System.fetch_env!("JOURNAL_ROOT_DIR")
config :logger, level: :info
