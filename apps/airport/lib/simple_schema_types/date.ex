defmodule SimpleSchema.Type.Date do
  @moduledoc """
  Date types such as `"2017-12-25"` for SimpleSchema.
  It is compatible with `full-date` described here:
  https://tools.ietf.org/html/rfc3339#section-5.6
  """

  @behaviour SimpleSchema

  @impl SimpleSchema
  def schema(_opts) do
    :string
  end

  @impl SimpleSchema
  def from_json(_schema, value, _opts) do
    case Date.from_iso8601(value) do
      {:ok, date} -> {:ok, date}
      {:error, reason} -> {:error, reason}
    end
  end

  @impl SimpleSchema
  def to_json(_schema, value, _opts) do
    {:ok, Date.to_iso8601(value)}
  end
end
