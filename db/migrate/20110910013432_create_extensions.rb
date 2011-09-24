class CreateExtensions < ActiveRecord::Migration
  def change
    create_table :extensions do |t|
      t.string :name
      t.string :image
      t.string :ruby_gem, :default => nil
      t.text :ruby_gem_cache, :default => nil
      t.belongs_to :user
      %w(homepage source_code documentation mailing_list).each do |link|
        t.string link, :default => nil
      end
      t.timestamps
    end
  end
end
