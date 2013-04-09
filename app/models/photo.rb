class Photo < ActiveRecord::Base

  attr_accessible :title, :image

  has_attached_file :image,
    path: ':rails_root/public/system/:class/:id/:style/:filename',
    url: '/system/:class/:id/:style/:filename',
    styles: {
      thumb: '300x200#',
      cropped: '750x500#'
    }
end