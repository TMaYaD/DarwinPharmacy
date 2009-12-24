authorization do  
  role :admin do  
    has_permission_on [:bills, :customers, :product_batches, :products, :users], :to => [:index, :show, :new, :create, :edit, :update, :destroy]  
  end  
end  

