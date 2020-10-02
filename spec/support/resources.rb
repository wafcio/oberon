class TextPostResource < Oberon::Resource
  attributes :title, :description

  attribute :slug do |resource|
    "#{resource.object.id}-slug"
  end

  relationships :categories, :blog

  relationship :user

  relationship :comments

  relationship :tags do
    [OpenStruct.new(name: "foo"), OpenStruct.new(name: "bar")]
  end
end

class CategoryResource < Oberon::Resource

end

class BlogResource < Oberon::Resource

end

class UserResource < Oberon::Resource

end

class CommentResource < Oberon::Resource

end

class TagResource < Oberon::Resource

end
