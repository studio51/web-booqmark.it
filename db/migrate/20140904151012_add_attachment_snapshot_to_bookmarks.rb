class AddAttachmentSnapshotToBookmarks < ActiveRecord::Migration
  def self.up
    change_table :bookmarks do |t|
      t.attachment :snapshot
    end
  end

  def self.down
    remove_attachment :bookmarks, :snapshot
  end
end
