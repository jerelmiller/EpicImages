class Special < ActiveRecord::Base

  attr_accessible :title, :poster

  has_attached_file :poster,
    path: ':rails_root/public/system/:class/:id/:style/:filename',
    url: '/system/:class/:id/:style/:filename',
    styles: {
      small: '200x200>',
      regular: '400x400>'
    }
end