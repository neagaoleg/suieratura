class Projimage < ActiveRecord::Base

belongs_to :user, :class_name => 'user', :foreign_key => 'user_id'

has_attachment :content_type => :image, 
:storage => :file_system, 
:max_size => 5.megabytes,
:resize_to => '620x400>',
:thumbnails => { :thumb => '100x100>' }


###SPECIAL NOTE: windows does not pass the image size with the file to attachment_fu.  
###You can find the fix here: http://epirsch.blogspot.com/2008/01/fixing-attachmentfu-on-windows-like.html
###Or, you can leave the follwoing line commented and try the fix at a later time.  attachment_fu will still work.
#validates_as_attachment

  before_thumbnail_saved do |record, thumbnail|
    thumbnail.user_id = record.user_id
    thumbnail.primary = false
  end

# Override the default AttachmentFu error messages.
  def validate
    if filename.nil?
      errors.add_to_base("You must choose a file to upload")
    else
      # Images should only be GIF, JPEG, or PNG
      enum = attachment_options[:content_type]
      unless enum.nil? || enum.include?(send(:content_type))
        errors.add_to_base("You can only upload images (GIF, JPEG, or PNG)")
      end
      # Images should be less than UPLOAD_LIMIT MB.
      enum = attachment_options[:size]
      unless enum.nil? || enum.include?(send(:size))
        msg = "Images should be smaller than 1 MB"
        errors.add_to_base(msg)
      end
    end
  end

end