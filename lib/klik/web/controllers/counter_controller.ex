defmodule Klik.Web.CounterController do
  use Klik.Web, :controller

  alias Klik.Counters

  def create(conn, _params) do
    case Counters.create_counter() do
      {:ok, counter} ->
        conn
        |> put_flash(:info, "Counter created successfully.")
        |> redirect(to: counter_path(conn, :show, counter))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "There was an error creating counter.")
        render("index.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    counter = Counters.get_counter!(id)
    render(conn, "show.html", counter: counter)
  end

  def edit(conn, %{"id" => id}) do
    counter = Counters.get_counter!(id)
    changeset = Counters.change_counter(counter)
    render(conn, "edit.html", counter: counter, changeset: changeset)
  end

  def update(conn, %{"id" => id, "counter" => counter_params}) do
    counter = Counters.get_counter!(id)

    case Counters.update_counter(counter, counter_params) do
      {:ok, counter} ->
        conn
        |> put_flash(:info, "Counter updated successfully.")
        |> redirect(to: counter_path(conn, :show, counter))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", counter: counter, changeset: changeset)
    end
  end
end
