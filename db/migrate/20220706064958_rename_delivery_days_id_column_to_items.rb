class RenameDeliveryDaysIdColumnToItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :delivery_days_id, :shipping_time_id
  end
end
