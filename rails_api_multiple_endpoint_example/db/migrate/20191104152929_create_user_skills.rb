class CreateUserSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :user_skills do |t|
      t.belongs_to :user
      t.belongs_to :skill

      t.timestamps
    end
  end
end
