class AddTestData < ActiveRecord::Migration
  def up
    Product.delete_all
    Product.create(:title=>'test title',
    :description=>%{<p>description line</p>},
    :image_url=>'/images/test.jpg',
    :price=>30.01)
  end

  def down
    Product.delete_all
  end
end
