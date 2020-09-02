import Config
config :peerage, via: Peerage.Via.List, node_list: [
  :"journal@free-instance",
  :journal@mantis
]
import_config "#{Mix.env()}.exs"

