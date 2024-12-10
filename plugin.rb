# frozen_string_literal: true

# name: discourse-svelte-companion
# about: TODO
# meta_topic_id: TODO
# version: 0.0.1
# authors: Discourse
# url: TODO
# required_version: 2.7.0

gem "parallel", "1.26.3", { require: false }
gem "ruby-progressbar", "1.13.0", { require: false }
gem "securerandom", "0.4.0", { require: false }

enabled_site_setting :svelte_companion_enabled

module ::DiscourseSvelteCompanion
  PLUGIN_NAME = "discourse-svelte-companion"
  POST_CUSTOM_FIELD_GLOBAL_ID = "global_id".freeze
end

require_relative "lib/my_plugin_module/engine"

after_initialize do
  # Code which should run after Rails has finished booting
  register_post_custom_field_type(DiscourseSvelteCompanion::POST_CUSTOM_FIELD_GLOBAL_ID, :string)
  require 'securerandom'

  NewPostManager.class_eval do
    def initialize(user, args)
      @user = user
      if args[DiscourseSvelteCompanion::POST_CUSTOM_FIELD_GLOBAL_ID].nil?
        args[DiscourseSvelteCompanion::POST_CUSTOM_FIELD_GLOBAL_ID] = SecureRandom.hex(SiteSetting.svelte_companion_global_id_length_half)
      end
      @args = args.delete_if { |_, v| v.nil? }
    end
  end

end
