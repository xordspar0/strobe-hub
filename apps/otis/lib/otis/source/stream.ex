defprotocol Otis.Source.Stream do
  @moduledoc "Defines a protocol for extracting a stream from a source"

  @type t :: %{}

  @doc """
  Returns a stream of raw PCM audio data
  """
  @spec open!(t, non_neg_integer) :: Enumerable.t
  def open!(stream, packet_size_bytes)

  @doc """
  Returns a stream of raw PCM audio data
  """
  @spec close(t, :file.io_device) :: :ok | {:error, :file.posix | :badarg | :terminated}
  def close(file, stream)

  @doc "Returns the audio type as a {extension, mime type} tuple"
  @spec audio_type(t) :: {binary, binary}
  def audio_type(stream)
end

defimpl Otis.Source.Stream, for: Otis.Filesystem.File do
  alias Otis.Filesystem.File

  def open!(%File{path: path}, packet_size_bytes) do
    Elixir.File.stream!(path, [], packet_size_bytes)
  end

  def close(%File{}, stream) do
    Elixir.File.close(stream)
  end

  def audio_type(%File{metadata: metadata}) do
    {metadata.extension, metadata.mime_type}
  end
end
