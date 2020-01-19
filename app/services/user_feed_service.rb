class UserFeedService
  PER_PAGE = 10
  QUESTION_DISPLAY_TYPE = 'question'
  ANSWER_DISPLAY_TYPE = 'answer'
  SHARE_DISPLAY_TYPE = 'share'

  def initialize(user:, page: 1)
    @user = user
    @feed = []

    # Maps to prevent dupes
    @answers_map = {}
    @questions_map = {}
    @shares_map = {}

    @page = page.to_i
  end

  def get_feed
    fetch_content

    rank_by_recency

    return @feed
  end

  private

  def rank_by_recency
    @feed.sort_by! { |hash| hash["timestamp_index"] }.reverse!
  end

  def fetch_content
    @feed.concat(get_shares)
    @feed.concat(get_answers)
    @feed.concat(get_questions)
  end

  def get_shares
    return [] if @user.nil?

    collection =  @user.shares
                       .order(created_at: :desc)
                       .limit(PER_PAGE)
                       .offset((@page - 1) * PER_PAGE)
    return convert_to_json_with_post_type(collection: collection, display_type: SHARE_DISPLAY_TYPE)
  end

  def get_answers
    return [] if @user.nil?

    collection =  @user.answers
                        .order(created_at: :desc)
                        .limit(PER_PAGE)
                        .offset((@page - 1) * PER_PAGE)
    return convert_to_json_with_post_type(collection: collection, display_type: ANSWER_DISPLAY_TYPE)
  end

  def get_questions
    return [] if @user.nil?

    collection =  @user.questions.order(created_at: :desc).limit(PER_PAGE).offset((@page - 1) * PER_PAGE)
    return convert_to_json_with_post_type(collection: collection, display_type: QUESTION_DISPLAY_TYPE)
  end

  def convert_to_json_with_post_type(collection:, display_type:)
    json = []
    collection.each do |item|
      attributes = item.attributes

      if item.try(:user)
        if item.is_a?(Share)
          attributes = attributes.merge({'user' => item.answer.user.attributes})
          attributes['user']['children_profile'] = item.answer.user.children_profile
          attributes['user']['avatar_url'] = item.answer.user.avatar.url
        else
          attributes = attributes.merge({'user' => item.user.attributes})
          attributes['user']['children_profile'] = item.user.children_profile
          attributes['user']['avatar_url'] = item.user.avatar.url
        end
      end

      if item.is_a?(Answer)
        next if @answers_map[item['id']].present?
        @answers_map[item['id']] = true

        attributes = attributes.merge({'question' => item.question.attributes})
        attributes['is_bookmarked_by_current_user'] = item.bookmarked_by?(@user)
        attributes['is_shared_by_current_user'] = item.shared_by?(@user)
      end

      if item.is_a?(Share)
        next if @shares_map[item['id']].present?
        @shares_map[item['id']] = true

        attributes = attributes.merge({'question' => item.answer.question.attributes})
        attributes['is_bookmarked_by_current_user'] = item.answer.bookmarked_by?(@user)
        attributes['is_shared_by_current_user'] = item.answer.shared_by?(@user)
        attributes = attributes.merge({"answer" => item.answer.attributes})

        attributes = attributes.merge({"shared_by" => item.user.attributes})
      end

      if item.is_a?(Question)
        next if @questions_map[item['id']].present?
        @questions_map[item['id']] = true

        attributes = attributes.merge({"category_name" => item.category_name})
      end

      attributes['display_type'] = display_type

      # Create a timestamp index for ranking by recency
      # refs: UserFeedService#rank_by_recency
      attributes['timestamp_index'] = item.created_at

      json.push(attributes)
    end

    return json
  end
end