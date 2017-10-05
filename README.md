# README

Implementing 'Shrine gem'

add to your gemfile

```rb
# Gemfile
gem "shrine"
```

Implementing an instagram duplicate application on rails.
Week 8 of Coder Academy in Sydney

Warning : the documentation for the 'Shrine gem' is super cryptic.

 to implement the gem you need to fun the following steps:
First
`rails g scaffold Photo image_data:text user:references caption`
this generates our Photo controller models and views


now create a new initializer inside config called shrine.rb
 fill it with the following:


```rb
require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
  store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"), # permanent
}

Shrine.plugin ::activerecord
```

create a new model image_uploader.rb
paste the following:
```rb
class ImageUploader < Shrine
  # plugins and uploading logic
end
```

create another model called photo.rb
paste the following:
```rb
class Photo < Sequel::Model # ActiveRecord::Base
  include ImageUploader::Attachment.new(:image) # adds an `image` virtual attribute
end
```
