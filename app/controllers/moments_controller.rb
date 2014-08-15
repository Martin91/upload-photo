class MomentsController < ApplicationController
  def index
  end

  def new
  end

  def create
    moment = Moment.create photo: preprocess_uploaded_photo
  end

  def download
  end

  private
  def preprocess_uploaded_photo
    encoded_photo_data = params[:moment][:photo]

    image_data = Base64.decode64(encoded_photo_data['data:image/png;base64,'.length .. -1])
    tempfile = Tempfile.new ['upload', 'png']
    tempfile.binmode
    tempfile.write(image_data)

    ActionDispatch::Http::UploadedFile.new(tempfile: tempfile,
      filename: 'upload.png')
  end
end
