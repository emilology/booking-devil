ActiveAdmin.register Booking do

  index do
    column :name, sortable: true
    column :dietary_preferences, sortable: true
    column :phone_number, sortable: true
    column :number_of_visitors, sortable: true
    column :time, sortable: true
    column :date, sortable: true
  end

  config.filters = false

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :dietary_preferences, :phone_number, :number_of_visitors, :time, :date
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

end
