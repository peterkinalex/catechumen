class Assetcategory < ActiveRecord::Base
  
  has_many :assets, :foreign_key => 'category_id'
  
  has_many    :subs,    :class_name => 'Assetcategory', :foreign_key => 'parent_id'
  belongs_to  :parent,  :class_name => 'Assetcategory', :foreign_key => 'parent_id'

  ASSETTYPE = [
             #  Displayed       stored in db
             [I18n.t('assetcategories.fixed'),1],
             [I18n.t('assetcategories.inventory'),2]
  ]
  
  def render_type
      (Assetcategory::ASSETTYPE.find_all{|disp, value| value == cattype_id }).map {|disp, value| disp}
  end
  
end
