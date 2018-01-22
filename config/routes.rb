Rails.application.routes.draw do
  


  namespace 'v1' do

      
    resource :sessions , only: [:create , :destroy ]
    
    resource :companies , only: [:create , :show , :update ] do
    end

    resources :employees do 
      get :get_employee_projects , on: :member 
      put :edit_employee_projects , on: :member
    end 
    resources :projects do
      get :get_project_employees , on: :member
      put :edit_project_employees , on: :member
    end
    
    resource :passwords , only: [:forgot , :recover , :update] do 
      post :forgot  #,  on: :collection
      put :recover #, on: :member
    end

  end

end
