base_admins = [
{:name => 'Admin', :email => 'admin@admin.com', :password => 'password1!'}
]

base_admins.each do |admin|
  Admin.create(admin)
end