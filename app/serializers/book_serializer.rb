class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author

  def author
    {
      id: object.author.id,
      name: object.author.first_name + " " +object.author.last_name,
      age: object.author.age
    }
  end
end
