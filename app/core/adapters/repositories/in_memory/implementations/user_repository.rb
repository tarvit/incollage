class Incollage::Repository::UserInMemoryRepository < Incollage::Repository::InMemoryBase

  def username_occupied?(username)
    exists?(username: username)
  end

  protected

  def validate_entity!(entity)
    raise Incollage::Entity::EntityIsInvalidError unless valid_username?(entity)
    super
  end

  def valid_username?(entity)
    present_user = find(id: entity.id, username: entity.username)
    return true if present_user
    !username_occupied?(entity.username)
  end

end
