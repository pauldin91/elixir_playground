defmodule FileUploadDemoWeb.ProductLive.Index do
  use FileUploadDemoWeb, :live_view

  alias FileUploadDemo.Products

  def mount(_params, _session, socket) do
    products = Products.list_products()

    likes =
      products
      |> Enum.map(fn p -> {p.id, 0} end)
      |> Map.new()

    dislikes =
      products
      |> Enum.map(fn p -> {p.id, 0} end)
      |> Map.new()

    dbg(likes)

    socket =
      socket
      |> assign(:products, products)
      |> assign(:likes, likes)
      |> assign(:dislikes, dislikes)

    {:ok, socket}
  end

  def handle_event("like", %{"id" => id}, socket) do
    id = String.to_integer(id)
    likes = Map.put(socket.assigns.likes, id, socket.assigns.likes[id] + 1)

    socket =
      socket
      |> assign(:likes, likes)

    {:noreply, socket}
  end

  def handle_event("dislike", %{"id" => id}, socket) do
    id = String.to_integer(id)

    dislikes = Map.put(socket.assigns.dislikes, id, socket.assigns.dislikes[id] + 1)

    socket =
      socket
      |> assign(:dislikes, dislikes)

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>
      Live view!
    </h1>

    <div :for={product <- @products}>
      <p>{product.name}</p>

      <div>
        <.icon name="hero-hand-thumb-up-mini" phx-click="like" phx-value-id={product.id} />
        {@likes[product.id]}
        <.icon name="hero-hand-thumb-down-mini" phx-click="dislike" phx-value-id={product.id} />
        {@dislikes[product.id]}
      </div>
    </div>
    """
  end
end
