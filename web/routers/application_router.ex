defmodule ApplicationRouter do
  use Dynamo.Router
  :random.seed( :os.timestamp)
  Redis.start

  prepare do
    # Pick which parts of the request you want to fetch
    # You can comment the line below if you don't need
    # any of them or move them to a forwarded router
    conn.fetch([:cookies, :params])
  end

  # It is common to break your Dynamo into many
  # routers, forwarding the requests between them:
  # forward "/posts", to: PostsRouter

  get "/" do
    conn = conn.assign(:title, "Welcome to Dynamo!")
    render conn, "index.html"
  end

  def new_hash(url) do
    r = SecureRandom.hex(3)
    case Redis.get(r) do
      :undefined -> Redis.set(r, url)
                    r
      _ -> new_hash(url)
    end
  end

  post "set" do
    url = conn.params[:url]
    res = new_hash(url)
    conn.resp 200, "#{conn.scheme}://#{conn.host}:#{conn.port}/#{res}"
  end

  get "/**" do
    url = conn.params[:*]
    res = Redis.get(url)
    case res do
      :undefined -> 404
      _ -> redirect conn, to: res
    end
  end

end
