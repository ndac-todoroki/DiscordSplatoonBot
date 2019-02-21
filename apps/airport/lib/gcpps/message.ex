defmodule GCPPS.Message do
  @moduledoc """
  Definition and functions to decode valid maps into Message structs.
  """

  alias __MODULE__, as: Message
  require Logger

  @typedoc """
  GooglePubSub Message struct.
  """
  @type t :: %Message{}
  defstruct attributes: %{},
            data: %{},
            message_id: nil

  defmodule ParseError do
    @moduledoc """
    Exception to raise when the message parse fails.
    """

    defexception [:message]

    def new(message) do
      %__MODULE__{message: message}
    end

    defimpl Plug.Exception, for: __MODULE__ do
      def status(_exp), do: 422
    end
  end

  @typedoc "an atom explaning the reason of an error"
  @type reason :: atom

  @typedoc "a function to parse a map into some struct"
  @type parser :: (map -> struct)

  @typedoc "options"
  @type parse_opts :: keyword(parser)

  @spec from_request(map, parse_opts) :: {:ok, Message.t()} | {:error, reason}
  @doc """
  Converts an already parsed GCPPS request JSON data map to a `GCPPS.Message` struct.
  You'd better pass a function which parses the attributes map into a struct,
  or otherwise the original string-key map will be placed in the value of `attributes` key.

  ### Options
  - attr_parser
    - a function which receives the `attributes` map and parses
  - data_parser
    - a function which receives the `data` map and parses
  """
  def from_request(parsed_request, opts \\ [])
      when parsed_request |> is_map and opts |> is_list() do
    with %{
           "message" => message,
           "subscription" => subscription_uri
         } <- parsed_request do
      message = message |> Map.put_new("attributes", %{})
      from_message(message, opts)
    else
      _ ->
        {:error, :invalid_request_format}
    end
  end

  @spec from_request!(map, parse_opts) :: Message.t() | no_return
  @doc """
  Converts an already parsed GCPPS request JSON data map to a `GCPPS.Message` struct.
  This function will raise an error.

  ### Options
  - attr_parser
    - a function which receives the `attributes` map and parses
  - data_parser
    - a function which receives the `data` map and parses
  """
  def from_request!(parsed_request, opts \\ [])
      when parsed_request |> is_map and opts |> is_list() do
    case from_request(parsed_request, opts) do
      {:ok, message} ->
        message

      {:error, reason} ->
        raise ParseError, message: reason |> to_string()
    end
  end

  @spec from_message(map, parse_opts) :: {:ok, Message.t()} | {:error, reason}
  @doc """
  Converts an already parsed GCPPS message JSON data map to a `GCPPS.Message` struct.
  """
  def from_message(parsed_message, opts \\ [])
      when parsed_message |> is_map and opts |> is_list() do
    # parse options
    attr_parser = opts |> Keyword.get(:attr_parser, & &1)
    data_parser = opts |> Keyword.get(:data_parser, & &1)

    with %{
           "attributes" => attributes_map,
           "data" => encoded_data,
           "message_id" => message_id
         } <- parsed_message,
         {:ok, decoded_data} <- encoded_data |> Base.decode64(padding: false),
         {:ok, data_map} <- decoded_data |> Jason.decode() do
      # parse maps, raises on error
      attributes = if attr_parser, do: attributes_map |> attr_parser.(), else: %{}
      data = if data_parser, do: data_map |> data_parser.(), else: ""

      message = %Message{
        attributes: attributes,
        data: data,
        message_id: message_id
      }

      {:ok, message}
    else
      :error ->
        {:error, :data_decoding_unprocessable}

      {:error, %Jason.DecodeError{}} ->
        {:error, :data_json_parse_error}

      _ ->
        {:error, :invalid_message_format}
    end
  end

  @spec from_message!(map, parse_opts) :: Message.t() | no_return
  def from_message!(parsed_message, opts \\ [])
      when parsed_message |> is_map and opts |> is_list() do
    case from_message(parsed_message, opts) do
      {:ok, message} ->
        message

      {:error, reason} ->
        raise ParseError, message: reason |> to_string()
    end
  end
end
