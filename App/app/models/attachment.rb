class Attachment < ActiveRecord::Base

  belongs_to :project

  def uploaded_file=(incomming_file)
    self.filename=incomming_file.original_filename
    self.content_type = incomming_file.content_type
    self.attached = incomming_file.read
  end

  def filename=(a_filename)
    write_attribute("filename", clear_filename(a_filename))
  end

  private
    def clear_filename(a_filename)
      #Filename only, other than whole path (possibly)
      cleared_filename = File.basename(a_filename)

      #Replace all non-alphanumeric, underscore or periods with underscores
      cleared_filename.gsub(/[^\w\.\-]/, '_')
    end
end
