#README

This is a basic sample project for setting up carrierwave on Rails 4.1 and storing images in Amazon S3.

##Basic setup

Add gem 'carrierwave' to your gemfile to add carrierwave.
Add gem 'mini_magick' to your gemfile to be able to create thumbnails and control image size.  Note you will have to install the ImageMagick library.
Add gem 'fog' for storing images in Amazon S3.

##Configuring carrierwave

Follow along with the carrierwave documentation: https://github.com/carrierwaveuploader/carrierwave

One thing I did differently than the documentation was setup initializer/carrierwave.rb like this:

'''ruby

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
        :provider               => 'AWS',
        :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
        :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
      }
      config.fog_directory  = ENV['S3_BUCKET']
  else
    config.storage = :file
  end
end
'''

This implementation sets up storage to be hosted on S3 via fog in the production environment and file storage for the development environment.


Also note in this example I am using a model backed form to upload the image.  In Rails 4 you do not need to add html: { multipart: true } in the form block if it is model backed.

