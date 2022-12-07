Rails.application.routes.draw do
  namespace(:api) do
    namespace(:v1) do
      resources(:items,       only: [:index, :show])

      resources(:merchants,       only: [:index, :show, :create]) do
        resources(:items,         only: [:index])
      end
    end
  end
end
