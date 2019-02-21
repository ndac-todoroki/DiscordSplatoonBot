defmodule GCPPS.Message.Attributes do
  @type t :: %__MODULE__{}
  defstruct [
    :type,
    :timestamp
  ]

  defmodule AttributesSchema do
    import SimpleSchema, only: [defschema: 2]

    defschema(
      [
        type: {:string, optional: true, default: ""}
      ],
      tolerant: true
    )

    defmodule ParseError do
      defexception [:message]

      defimpl Plug.Exception, for: __MODULE__ do
        def status(_exp), do: 422
      end
    end
  end

  @spec parse(map) :: t | no_return
  @doc """
  Parses a decoded json map into a struct.
  Raises if not following the simple schema.
  """
  def parse(json_map) do
    case SimpleSchema.from_json(AttributesSchema, json_map) do
      {:ok, map} ->
        struct(__MODULE__, map |> Map.from_struct())

      {:error, reason} ->
        raise AttributesSchema.ParseError, message: reason
    end
  end
end
