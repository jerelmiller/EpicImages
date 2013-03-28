class Photo < ActiveRecord::Base

  attr_accessible :title, :image

  has_attached_file :image,
    path: ':rails_root/public/system/:class/:id/:style/:filename',
    url: '/system/:class/:id/:style/:filename',
    styles: {
      thumb: '200x200>',
      regular: '500x500>',
      large: '800x800>'
    }
end