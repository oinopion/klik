defmodule Klik.Web.IncrementController do
  use Klik.Web, :controller
  alias Klik.Counters

  def create(conn, %{"counter_id" => counter_id}) do
    counter = Counters.get_counter!(counter_id)

    case Counters.increment_counter(counter) do
      {:ok, counter, _increment} ->
        conn
        |> redirect(to: counter_path(conn, :show, counter))
      {:error, %Ecto.Changeset{}} ->
        conn
        |> put_flash(:error, "There was an error incrementing the counter.")
        |> redirect(to: counter_path(conn, :show, counter))
    end
  end
end
