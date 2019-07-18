defmodule WakandaBot do
  use Application
  import Supervisor.Spec
  require Logger
  def start(_type, _args) do
    token = ExGram.Config.get(:ex_gram, :token)
    children = [
      supervisor(ExGram, []),
      supervisor(WakandaBot.Bot, [:polling, token])
    ]
    opts = [strategy: :one_for_one, name: WakandaBot]
    case Supervisor.start_link(children, opts) do
      {:ok, _} = ok ->
        Logger.info("Starting WakandaBot")
        ok
      error ->
        Logger.error("Error starting WakandaBot")
        error
    end
  end
end
