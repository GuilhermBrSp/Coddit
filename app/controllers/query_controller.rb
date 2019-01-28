class QueryController < ApplicationController


  def search
    keywords = normalizedKeywords

    @query_result  = Post.joins("left join taggings on taggings.post_id = posts.id").joins("left join tags on tags.id = taggings.tag_id").where('posts.title ILIKE ? OR posts.body ILIKE ? OR tags.name = ?',"%#{keywords[0]}%","%#{keywords[0]}%","#{keywords[0]}").distinct
    keywords.each do |keyword|
      @query_result = postsMatch(@query_result,keyword)
    end
    render 'queries/query_result'

  end


  private

  def postsMatch(query,keyword)
   query.joins("left join taggings on taggings.post_id = posts.id").joins("left join tags on tags.id = taggings.tag_id").where('posts.title ILIKE ? OR posts.body ILIKE ? OR tags.name = ?',"%#{keyword}%","%#{keyword}%","#{keyword}").distinct
  end

  def normalizedKeywords()
    params[:query_params].gsub(/[[:blank:]]+/, ' ').split(',').map {|keyword| keyword.strip}


  end
end
