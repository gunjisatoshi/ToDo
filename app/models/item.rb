class Item < ActiveRecord::Base
  belongs_to :category
  belongs_to :note

  validates_associated :category
  validates_inclusion_of :priority, :in=>1..5,
                         :message => 'must be between 1 (high) and 5 (low)'
  validates_presence_of :description
  validates_length_of :description, :maximum=>40

  def befire_destroy
    unless note_id.nil?
      Note.find(note_id).destroy
    end
  end
end
