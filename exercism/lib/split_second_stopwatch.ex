defmodule SplitSecondStopwatch do
  @doc """
  A stopwatch that can be used to track lap times.
  """

  @type state :: :ready | :running | :stopped

  defmodule Stopwatch do
    @type t :: :todo
    defstruct [:state, :laps, :current_lap_ts]
  end

  @spec new() :: Stopwatch.t()
  def new() do
    %Stopwatch{laps: [], state: :ready}
  end

  @spec state(Stopwatch.t()) :: state()
  def state(stopwatch) do
    stopwatch.state
  end

  @spec current_lap(Stopwatch.t()) :: Time.t()
  def current_lap(stopwatch) do
    cond do
      stopwatch.state == :running ->
        track(stopwatch.current_lap_ts)

      true ->
        {:ok, time} = Time.new(0, 0, 0)
        time
    end
  end

  @spec previous_laps(Stopwatch.t()) :: [Time.t()]
  def previous_laps(stopwatch) do
    stopwatch.laps
  end

  @spec advance_time(Stopwatch.t(), Time.t()) :: Stopwatch.t()
  def advance_time(stopwatch, time) do
    cond do
      stopwatch.state == :running ->
        %Stopwatch{
          laps: [track(stopwatch.current_lap_ts) | stopwatch.laps],
          current_lap_ts: time,
          state: stopwatch.state
        }

      true ->
        stopwatch
    end
  end

  @spec total(Stopwatch.t()) :: Time.t()
  def total(stopwatch) do
    cond do
      stopwatch.state == :running ->
        track(stopwatch.current_lap_ts)

      true ->
        {:ok, time} = Time.new(0, 0, 0)
        time
    end
  end

  @spec start(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def start(stopwatch) do
    cond do
      stopwatch.state == :ready ->
        %Stopwatch{laps: stopwatch.laps, current_lap_ts: Time.utc_now(), state: :running}

      stopwatch.state == :stopped ->
        %Stopwatch{
          laps: stopwatch.laps,
          current_lap_ts: Time.utc_now(),
          state: :running
        }

      true ->
        {:error, "cannot start an already running stopwatch"}
    end
  end

  @spec stop(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def stop(stopwatch) do
    cond do
      stopwatch.state == :running ->
        %Stopwatch{
          laps: stopwatch.laps,
          current_lap_ts: Time.utc_now(),
          state: :stopped
        }

      true ->
        {:error, "cannot stop a stopwatch that is not running"}
    end
  end

  @spec lap(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def lap(stopwatch) do
    cond do
      stopwatch.state == :running ->
        %Stopwatch{
          laps: [
            track(stopwatch.current_lap_ts)
            | stopwatch.laps
          ],
          current_lap_ts: Time.utc_now(),
          state: :running
        }

      true ->
        {:error, "cannot lap a stopwatch that is not running"}
    end
  end

  @spec reset(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def reset(stopwatch) do
    cond do
      stopwatch.state != :stopped -> {:error, "cannot reset a stopwatch that is not stopped"}
      true -> %Stopwatch{laps: stopwatch.laps, state: :ready}
    end
  end

  def track(time) do
    Time.from_seconds_after_midnight(Time.diff(Time.utc_now(), time))
  end
end
