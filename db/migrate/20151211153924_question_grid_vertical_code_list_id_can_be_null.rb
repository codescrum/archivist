class QuestionGridVerticalCodeListIdCanBeNull < ActiveRecord::Migration
  def change
    change_column_null(:question_grids, :vertical_code_list_id, true)
  end
end
