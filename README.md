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


one of the main problems with this gem was the permit params inside the photo controller :
you have to make sure it takes :image and not :image_data





sending data from the controller to the view; one of my errors when I was creating new images, it wasn't accepting user information from devise, when there was no user signed in, it would error out.

One attempt to fix this was to hide the new post link until a user signed in, I then updated my photos controller
```
def set_photo
  # @photo = Photo.find(params[:id]) Originally this  I commented it out
  @data = {
    photo: Photo.find(params[:id]),
    user: current_user
  }
end
```

I then added a data hash which is pushed to my views with @data[:photo] or @data[:user]
this allowed me to store the user_id of the image uploader and also gives me the option to later add attributes which can be pushed to my views using @data[:attribute]


^ this proved a mistake and added unneeded complexity which then layered more problems.
Might have to replace this; as I was able to fix the problem "user must exist", by simply restricting photo uploads to users who are signed in.



Schema problems encountered: The next error I was having; User_id can't be found, after some investigating my schema, I found that my user_Id was actually user_id_id  

-- this was caused because I used t.references
in my migration file,

 which actually adds the "_ id" to the column on its own. resulting in a double up;
This was a great problem to solve, as it allowed me to learn how to rename database columns and it also was a good reminder to check my schema.rb after a migration to ensure correct names.

so to fix this i made a new migration file, rename_column with the following;


```class RenameColumn < ActiveRecord::Migration
  def change
      rename_column :photos, :user_id_id, :user
  end
end
```

it's important to rename to :user not user_id because references adds the _id_ again (so we would be at the same problem.)



this solves the original problem we had of not passing the user_data to the photos when they were created, which means I can now undo the entire set of sequences that passed the hash @data instead of @photo
