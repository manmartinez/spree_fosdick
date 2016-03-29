require 'net/sftp'

class Fosdick::FileUploader
  def initialize(host:, username:, password:, upload_path:)
    @host = host
    @username = username
    @password = password
    @upload_path = upload_path
  end

  def upload(*file_paths)
    Net::SFTP.start(host, username, password: password) do |sftp|
      file_paths.each do |local_path|
        sftp.upload! local_path, remote_path_for(local_path)
      end
    end
  end

  private

  attr_reader :host, :username, :password, :upload_path

  def remote_path_for(local_path)
    filename = File.basename(local_path)
    File.join(upload_path, filename)
  end
end
