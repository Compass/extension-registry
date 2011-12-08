class RemoveUnneededColumns < ActiveRecord::Migration
  def up
    %w(homepage source_code documentation mailing_list).each do |col|
      remove_column :extensions, col
    end
  end

  def down
    %w(homepage source_code documentation mailing_list).each do |col|
      add_column :extensions, col
    end
  end
end
