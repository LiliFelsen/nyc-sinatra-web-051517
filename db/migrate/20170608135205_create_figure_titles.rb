class CreateFigureTitles < ActiveRecord::Migration

  def change
    create_table :figure_titles do |t|
      t.references :figure
      t.references :title
    end
  end

end
