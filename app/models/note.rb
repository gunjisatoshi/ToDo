class Note < ActiveRecord::Base
  validates_presence_of :more_notes

  def before_destroy
    Item.find_by_note_id(id).update_attribute('note_id', nil)
  end
end
