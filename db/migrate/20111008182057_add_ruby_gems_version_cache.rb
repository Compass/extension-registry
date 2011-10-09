class AddRubyGemsVersionCache < ActiveRecord::Migration
  def up
    alter_table(:extensions) do |t|
      t.text :gem_version_cache
      t.timestamp :gem_version_last_updated
      t.timestamp :ruby_gem_cache_last_updted
    end
  end

  def down
    [:gem_version_cache, :gem_version_last_updated, :ruby_gem_cache_last_updted].each do |col|
      remove_column :extensions, col
    end
  end
end
