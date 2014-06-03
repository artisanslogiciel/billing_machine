# Add link to application home page
ActiveAdmin.register_page "Application" do
   controller do
     define_method(:index) do
       redirect_to root_path
     end
   end
 end
ActiveAdmin.register PaymentTerm do
  scope_to :current_user
end
