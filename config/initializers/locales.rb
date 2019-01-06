
# config/initializers/locale.rb

# 指定 I18n 库搜索翻译文件的路径
I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
