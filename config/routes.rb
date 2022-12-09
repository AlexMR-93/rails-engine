Rails.application.routes.draw do
  namespace(:api) do
    namespace(:v1) do
      namespace(:merchants) do
        resources(:find,         only: [:index],         controller: "search")
      end

      namespace(:items) do
        resources(:find_all,         only: [:index],         controller: "search")
      end

      resources(:items)

      resources(:merchants,       only: [:index, :show, :create]) do
        resources(:items,         only: [:index],         controller: "merchant_items")
      end
    end
  end

  get("/api/v1/items/:item_id/merchant",   to: "api/v1/merchants#show")
end
