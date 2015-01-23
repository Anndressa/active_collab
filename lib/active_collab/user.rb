class ActiveCollab::User

  attr_accessor :id, :name, :permalink, :state, :first_name, :last_name, :display_name, :short_display_name, :email, :photo, :company_id, :role_id

  def self.from_info(hash)
    user = ActiveCollab::User.new
    user.id = hash["id"].to_i
    user.name = hash["name"]
    user.permalink = hash["permalink"]
    user.state = hash["state"].to_i
    user.first_name = hash["first_name"]
    user.last_name = hash["last_name"]
    user.display_name = hash["display_name"]
    user.short_display_name = hash["short_display_name"]
    user.email = hash["email"]
    user.photo = hash["avatar"]["photo"]
    user.company_id = hash["company_id"]
    user.role_id = hash["role_id"]
    user
  end
end