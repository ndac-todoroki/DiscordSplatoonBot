defmodule GCPPS.Message.SchedulesData do
  require Logger

  @type t :: %__MODULE__{}
  defstruct [
    :channel_id,
    :command,
    :options
  ]

  defmodule SchedulesDataSchema do
    import SimpleSchema, only: [defschema: 2]

    defschema(
      [
        channel_id: {:integer, optional: false},
        command: {:string, optional: false, enum: ~w(news:latest)},
        options: {[:string], optional: true, default: []}
      ],
      tolerant: true
    )

    defmodule ParseError do
      defexception [:message]

      defimpl Plug.Exception, for: __MODULE__ do
        def status(_exp), do: 204
      end
    end
  end

  @spec parse(map) :: t | no_return
  @doc """
  Parses a decoded json map into account struct.
  Raises if not following the simple schema.
  """
  def parse(json_map) do
    case SimpleSchema.from_json(SchedulesDataSchema, json_map) do
      {:ok, map} ->
        struct(__MODULE__, map |> Map.from_struct)

      {:error, reason} ->
        Logger.error(fn -> {"Not following GCPPS schema", [reason: reason]} end)
        raise SchedulesDataSchema.ParseError, message: reason
    end
  end
end
