class ChangeCustomInfosTypeInIdCard < ActiveRecord::Migration
  def change
    change_column :id_cards, :custom_info_1, :text, :limit => 511
    change_column :id_cards, :custom_info_2, :text, :limit => 511
    change_column :id_cards, :custom_info_3, :text, :limit => 511
  end
end
