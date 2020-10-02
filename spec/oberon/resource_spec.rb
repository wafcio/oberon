RSpec.describe Oberon::Resource do
  let(:post) do
    OpenStruct.new(
      id: "foo-bar", title: "hello world", description: "lorem ipsum",
      blog: OpenStruct.new,
      categories: [OpenStruct.new, OpenStruct.new],
      comments: [OpenStruct.new, OpenStruct.new],
      user: OpenStruct.new
    )
  end
  let(:text_post_resource) { TextPostResource.new(post) }

  it "has id property from object" do
    expect(text_post_resource.id).to eq(post.id)
  end

  it "has type property from object" do
    expect(text_post_resource.type).to eq("text-posts")
  end

  it "has attributes" do
    expected_attributes = {
      title: "hello world",
      slug: "foo-bar-slug",
      description: "lorem ipsum"
    }

    expect(text_post_resource.attributes).to eq(expected_attributes)
  end

  it "has relationships" do
    relationships = text_post_resource.relationships
    expect(relationships).to be_a(Hash)
    expect(relationships.keys.sort).to match_array([:blog, :categories, :comments, :tags, :user])
    expect(relationships[:blog]).to be_a(Hash)
    expect(relationships[:blog].keys).to match_array([:data, :mapper])
    expect(relationships[:blog][:data]).to be_a(OpenStruct)
    expect(relationships[:blog][:mapper]).to eq(BlogResource)
    expect(relationships[:categories]).to be_a(Hash)
    expect(relationships[:categories].keys).to match_array([:data, :mapper])
    expect(relationships[:categories][:data]).to be_an(Array)
    expect(relationships[:categories][:mapper]).to eq(CategoryResource)
    expect(relationships[:comments]).to be_a(Hash)
    expect(relationships[:comments].keys).to match_array([:data, :mapper])
    expect(relationships[:comments][:data]).to be_an(Array)
    expect(relationships[:comments][:mapper]).to eq(CommentResource)
    expect(relationships[:tags]).to be_a(Hash)
    expect(relationships[:tags].keys).to match_array([:data, :mapper])
    expect(relationships[:tags][:data]).to be_an(Array)
    expect(relationships[:tags][:mapper]).to eq(TagResource)
    expect(relationships[:user]).to be_a(Hash)
    expect(relationships[:user].keys).to match_array([:data, :mapper])
    expect(relationships[:user][:data]).to be_a(OpenStruct)
    expect(relationships[:user][:mapper]).to eq(UserResource)
  end
end
