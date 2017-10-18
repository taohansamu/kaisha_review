# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

# Use bower
Rails.application.config.assets.paths << Rails.root.join("vendor","assets","bower_components")

Rails.application.config.assets.paths << Rails.root.join("vendor","assets","bower_components",
"bootstrap-sass-official","assets","fonts")

Rails.application.config.assets.precompile << %r(.*.(?:eot|svg|ttf|woff|woff2)$)
Rails.application.config.assets.precompile += %w( details.css )
Rails.application.config.assets.precompile += %w( details.js )