class HomeFeedService
  PER_PAGE = 10
  SHARES_BY_FOLLOWINGS_TYPE = 'shares_by_followings'
  ANSWERS_BY_FOLLOWINGS_TYPE = 'answers_by_followings'
  QUESTIONS_BY_FOLLOWINGS_TYPE = 'questions_by_followings'
  TRENDING_ANSWERS_TYPE = 'trending_answers'
  TRENDING_QUESTIONS_TYPE = 'trending_questions'
  NEW_ANSWERS_TYPE = 'new_answers'
  NEW_QUESTIONS_TYPE = 'new_questions'
  QUESTION_DISPLAY_TYPE = 'question'
  ANSWER_DISPLAY_TYPE = 'answer'
  SHARE_DISPLAY_TYPE = 'share'

  def initialize(user:, page: 1)
    @user = user
    @feed = []
    @page = page.to_i
  end

  def get_feed
    fetch_followings_content
    fetch_recommended_content

    rank_by_recency

    fetch_recent_content

    return @feed
  end

  private

  def rank_by_recency
    @feed.sort_by! { |hash| hash["timestamp_index"] }.reverse!
  end

  def fetch_followings_content
    @feed.concat(get_shares_by_followings)
    @feed.concat(get_answers_by_followings)
    @feed.concat(get_questions_by_followings)
  end

  def fetch_recommended_content
    @feed.concat(get_trending_answers)
    @feed.concat(get_trending_questions)
  end

  def fetch_recent_content
    @feed.concat(get_new_answers)
    @feed.concat(get_new_questions)
  end

  def get_shares_by_followings
    return [] if @user.nil?

    collection =  Share.joins('LEFT JOIN answers ON shares.answer_id = answers.id LEFT JOIN follows ON follows.following_id = shares.user_id')
                       .where('follows.follower_id = ?', @user.id)
                       .order(created_at: :desc)
                       .limit(PER_PAGE)
                       .offset((@page - 1) * PER_PAGE)
    return convert_to_json_with_post_type(collection: collection, post_type: SHARES_BY_FOLLOWINGS_TYPE, display_type: SHARE_DISPLAY_TYPE)
  end

  def get_answers_by_followings
    return [] if @user.nil?

    collection =  Answer.joins('LEFT JOIN follows ON follows.following_id = answers.user_id')
                        .where('follows.follower_id = ?', @user.id)
                        .order(created_at: :desc)
                        .limit(PER_PAGE)
                        .offset((@page - 1) * PER_PAGE)
    return convert_to_json_with_post_type(collection: collection, post_type: ANSWERS_BY_FOLLOWINGS_TYPE, display_type: ANSWER_DISPLAY_TYPE)
  end

  def get_questions_by_followings
    return [] if @user.nil?

    collection =  Question.joins('LEFT JOIN follows ON follows.following_id = questions.user_id')
                          .where('follows.follower_id = ?', @user.id)
                          .order(created_at: :desc)
                          .limit(PER_PAGE)
                          .offset((@page - 1) * PER_PAGE)
    return convert_to_json_with_post_type(collection: collection, post_type: QUESTIONS_BY_FOLLOWINGS_TYPE, display_type: QUESTION_DISPLAY_TYPE)
  end

  def get_trending_answers
    collection = Answer.order(created_at: :desc, bookmarks_count: :desc, shares_count: :desc).limit(PER_PAGE).offset((@page - 1) * PER_PAGE)
    return convert_to_json_with_post_type(collection: collection, post_type: TRENDING_ANSWERS_TYPE, display_type: ANSWER_DISPLAY_TYPE)
  end

  def get_trending_questions
    collection = Question.order(created_at: :desc, answers_count: :desc).limit(PER_PAGE).offset((@page - 1) * PER_PAGE)
    return convert_to_json_with_post_type(collection: collection, post_type: TRENDING_QUESTIONS_TYPE, display_type: QUESTION_DISPLAY_TYPE)
  end

  def get_new_answers
    collection = Answer.order(created_at: :desc).limit(PER_PAGE).offset((@page - 1) * PER_PAGE)
    return convert_to_json_with_post_type(collection: collection, post_type: NEW_ANSWERS_TYPE, display_type: ANSWER_DISPLAY_TYPE)
  end

  def get_new_questions
    collection = Question.order(created_at: :desc).limit(PER_PAGE).offset((@page - 1) * PER_PAGE)
    return convert_to_json_with_post_type(collection: collection, post_type: NEW_QUESTIONS_TYPE, display_type: QUESTION_DISPLAY_TYPE)
  end

  def convert_to_json_with_post_type(collection:, post_type:, display_type:)
    json = []
    collection.each do |item|
      attributes = item.attributes

      if item.try(:user)
        attributes = attributes.merge({'user' => item.user.attributes})
        attributes['user']['children_profile'] = item.user.children_profile
      end

      if item.is_a?(Answer)
        attributes = attributes.merge({'question' => item.question.attributes})
        attributes['is_bookmarked_by_current_user'] = item.bookmarked_by?(@user)
        attributes['is_shared_by_current_user'] = item.shared_by?(@user)
      end

      if item.is_a?(Share)
        attributes = attributes.merge({'question' => item.answer.question.attributes})
        attributes['is_bookmarked_by_current_user'] = item.answer.bookmarked_by?(@user)
        attributes['is_shared_by_current_user'] = item.answer.shared_by?(@user)
        attributes = attributes.merge({"answer" => item.answer.attributes})
      end

      attributes['post_type'] = post_type
      attributes['display_type'] = display_type

      # Create a timestamp index for ranking by recency
      # refs: HomeFeedService#rank_by_recency
      if post_type == SHARES_BY_FOLLOWINGS_TYPE
        attributes['timestamp_index'] = item.created_at
      else
        attributes['timestamp_index'] = item.created_at
      end
      json.push(attributes)
    end

    return json
  end
end