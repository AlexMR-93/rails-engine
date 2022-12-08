Rails.application.routes.draw do
  namespace(:api) do
    namespace(:v1) do
      resources(:items)

      resources(:merchants,       only: [:index, :show, :create]) do
        resources(:items,         only: [:index])
      end
    end
  end

  get("/api/v1/merchants/:id/items",   to: "items#show")
end
