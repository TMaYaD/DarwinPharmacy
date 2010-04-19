authorization do
  role :admin do
    has_permission_on [
    		:bills,
		:customers,
		:franchises,
		:product_batches,
		:products,
		:purchase_bills,
		:purchase_requests,
		:sale_bills,
		:audited_stock_records,
		:suppliers,
		:users
    ], :to => [:index, :crud]
    has_permission_on [:products, :product_batches], :to => [:autocomplete]

    has_permission_on [:report], :to => [:index, :retail_sales, :sales_tax]
    has_permission_on :user_sessions, :to => [:destroy]
  end

  role :operator do
    has_permission_on [:products, :product_batches], :to => [:index, :read, :create, :update]
    has_permission_on [:purchase_bills, :sale_bills], :to => [:index, :read, :create, :update]
    has_permission_on [:products, :product_batches], :to => [:autocomplete]
    has_permission_on :users do
      to :update
      if_attribute :id => is {user.id}
    end

    has_permission_on [:audited_stock_records], :to => [:index, :read, :create, :update]
    has_permission_on [:purchase_requests], :to => [:index, :read, :update, :destroy]

    has_permission_on :user_sessions, :to => [:destroy]
  end

  role :franchise do
    has_permission_on :customers, :to => [:read, :create, :update]
    has_permission_on :bills, :to => [:index, :create]
    has_permission_on :bills do
      to :read
      if_attribute :franchise => is_in {user.franchises}
    end
    has_permission_on :sale_bills do
      to :read
      if_attribute :franchise => is_in {user.franchises}
    end
    has_permission_on [:products, :product_batches], :to => [:autocomplete, :read, :index]
    has_permission_on [:audited_stock_records], :to => [:index]
    has_permission_on :users do
      to :update
      if_attribute :id => is {user.id}
    end
    has_permission_on :user_sessions, :to => [:destroy]

    has_permission_on :purchase_requests, :to => [:index, :create]
    has_permission_on :purchase_requests do
      to :read, :update, :destroy
      if_attribute :franchise => is_in {user.franchises}
    end
  end
  role :accountant do
    has_permission_on [:report], :to => [:index, :retail_sales, :sales_tax]
  end
  role :guest do
    has_permission_on :user_sessions, :to => [:new, :create]
  end
end
privileges do
  privilege :create do
    includes :new
  end
  privilege :read do
    includes :show
  end
  privilege :update do
    includes :edit
  end
  privilege :crud do
    includes :create, :read, :update, :destroy
  end
end

