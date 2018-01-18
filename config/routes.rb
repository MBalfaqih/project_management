Rails.application.routes.draw do
  


  namespace 'v1' do

    namespace 'company' do
      resource :sessions , only: [:create , :destroy ]
      resources :companies , only: [:create , :index ,:update ]
      resource :passwords , only: [:forgot , :recover , :update] do 
        post :forgot  #,  on: :collection
        put :recover #, on: :member
      end
    end
    
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

# Company.find_by(password_reset_link: params[:password_reset_link])

# # com = Company.find_by(email: params[:email])
# # if com 


#   def reset_lin
#     self.password_reset_link = regen    
#     save
#   end