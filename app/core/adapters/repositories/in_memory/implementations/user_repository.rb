class Incollage::Repository::UserInMemoryRepository < Incollage::Repository::InMemoryBase

  def username_occupied?(username)
    exists?(username: username)
  end

end
