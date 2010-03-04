authorization do
  role :admin do
    has_permission_on [:bills, :purchase_bills, :sale_bills, :products, :product_batches, :stock_inventories, :users, :franchises, :customers, :suppliers], :to => [:index, :crud]
    has_permission_on [:products, :product_batches], :to => [:autocomplete]

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

    has_permission_on [:stock_inventories], :to => [:index]

    has_permission_on :user_sessions, :to => [:destroy]
  end

  role :franchise do
    has_permission_on :customers, :to => [:index, :read, :create, :update]
    has_permission_on :bills, :to => [:index, :create]
    has_permission_on :bills do
      to :read
      if_attribute :franchise => is_in {user.franchises}
    end
    has_permission_on :sale_bills do
      to :read
      if_attribute :franchise => is {user.franchise}
    end
    has_permission_on [:products, :product_batches], :to => [:autocomplete, :read, :index]
    has_permission_on :users do
      to :update
      if_attribute :id => is {user.id}
    end

    has_permission_on :user_sessions, :to => [:destroy]
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

