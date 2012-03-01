class InsertGridData < ActiveRecord::Migration
  def up
  	Grid.create(:id => 1, :name => "A", :color => "#FDC83A", :width => 165)
  	Grid.create(:id => 2, :name => "B", :color => "#4FAEFE", :width => 300)
  	Grid.create(:id => 3, :name => "C", :color => "#7FFF3A", :width => 485)
  	Grid.create(:id => 4, :name => "D", :color => "#F73BC6", :width => 620)
  	Grid.create(:id => 5, :name => "E", :color => "#B64B51", :width => 658)
  	Grid.create(:id => 6, :name => "F", :color => "#A8A8A8", :width => 966)
  end

  def down
  	Grid.delete_all
  end
end
