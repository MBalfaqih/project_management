Rails.application.routes.draw do
  



  namespace 'v1' do

      
    resource :sessions , only: [:create , :destroy ]
    resource :companies , only: [:create , :show , :update ]

    resource :passwords , only: [:forgot , :recover , :update] do 
      post :forgot #,  on: :collection
      put :recover  # , on: :member
    end

    resources :employees do 
      resource :employee_projects , only: [:show , :update ]
      resources :tasks  #except
    end 

    resources :projects do
      resource :project_employees , only: [:show , :update]
      resources :tasks # execept
    end

  end

end
