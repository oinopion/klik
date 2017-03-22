defmodule Klik.Counters do
  @moduledoc """
  The boundary for the Counters system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Ecto.Multi
  alias Klik.Repo
  alias Klik.Counters.{Counter,Increment}

  @doc """
  Returns the list of counters.

  ## Examples

      iex> list_counters()
      [%Counter{}, ...]

  """
  def list_counters do
    Repo.all(Counter)
  end

  @doc """
  Gets a single counter.

  Raises `Ecto.NoResultsError` if the Counter does not exist.

  ## Examples

      iex> get_counter!(123)
      %Counter{}

      iex> get_counter!(456)
      ** (Ecto.NoResultsError)

  """
  def get_counter!(id), do: Repo.get!(Counter, id)

  @doc """
  Creates a counter.

  ## Examples

      iex> create_counter(%{field: value})
      {:ok, %Counter{}}

      iex> create_counter(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_counter(attrs \\ %{}) do
    %Counter{}
    |> counter_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a counter.

  ## Examples

      iex> update_counter(counter, %{field: new_value})
      {:ok, %Counter{}}

      iex> update_counter(counter, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_counter(%Counter{} = counter, attrs) do
    counter
    |> counter_changeset(attrs)
    |> Repo.update()
  end

  def increment_counter(%Counter{} = counter, attrs \\ %{}) do
    increment_cs = new_increment_changeset(counter, attrs)
    increment_by = get_change(increment_cs, :value, 1)
    update_query = increment_counter_value_query(counter, increment_by)

    result =
      Multi.new
      |> Multi.insert(:increment, increment_cs)
      |> Multi.update_all(:counters, update_query, [], returning: true)
      |> Repo.transaction()

    case result do
      # We know there's going to be only one counter
      {:ok, %{increment: increment, counters: {1, [counter]}}} ->
        {:ok, counter, increment}
      default ->
        default
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking counter changes.

  ## Examples

      iex> change_counter(counter)
      %Ecto.Changeset{source: %Counter{}}

  """
  def change_counter(%Counter{} = counter) do
    counter_changeset(counter, %{})
  end

  defp increment_counter_value_query(counter, increment_by) do
    from(
      c in Counter,
      where: c.id == ^counter.id,
      update: [inc: [value: ^increment_by]])
  end

  defp counter_changeset(%Counter{} = counter, attrs) do
    counter
    |> cast(attrs, [:name])
  end

  defp new_increment_changeset(counter, attrs) do
    %Increment{}
    |> cast(attrs, [:value])
    |> put_assoc(:counter, counter)
  end
end
