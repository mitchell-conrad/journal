import Config
config :journal, :timezone, System.fetch_env!("JOURNAL_TZ")
