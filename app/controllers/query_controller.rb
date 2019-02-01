class QueryController < ApplicationController
  def search
    keywords = normalized_keywords

    if keywords.empty?
      @query_not_found = 'Blank value'
      render 'queries/query_no_result.erb'
    else

      @query_result = Post.joins('left join taggings on taggings.post_id = posts.id').joins('left join tags on tags.id = taggings.tag_id').where('posts.title ILIKE ? OR posts.body ILIKE ? OR tags.name = ?', "%#{keywords[0]}%", "%#{keywords[0]}%", (keywords[0]).to_s).distinct
      keywords.each do |keyword|
        @query_result = posts_match(@query_result, keyword)
      end

      if @query_result.count == 0
        @query_not_found = "'#{keywords.join(',')}'"
        render 'queries/query_no_result.erb'

      else
        render 'queries/query_result'
      end
    end
  end

  private

  def posts_match(query, keyword)
    query.joins('left join taggings on taggings.post_id = posts.id').joins('left join tags on tags.id = taggings.tag_id').where('posts.title ILIKE ? OR posts.body ILIKE ? OR tags.name = ?', "%#{keyword}%", "%#{keyword}%", keyword.to_s).distinct
  end

  def normalized_keywords
    params[:query_params].gsub(/[[:blank:]]+/, ' ').split(',').map(&:strip)
  end
end
