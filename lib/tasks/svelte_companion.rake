# frozen_string_literal: true
desc 'add random 64-character-long global_id to all posts'
task 'svelte_companion:populate_global_id' => :environment do
  require 'securerandom'
  require 'parallel'
  Parallel.each(Post.all, progress: "Posts") do |post|
      post.update_column(DiscourseSvelteCompanion::POST_CUSTOM_FIELD_GLOBAL_ID,
                         SecureRandom.hex(SiteSetting.svelte_companion_global_id_length_half))
  end

end

