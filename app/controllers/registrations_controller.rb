class RegistrationsController < Devise::RegistrationsController
  respond_to :html, :js

  def new
    super do

      twitter_data = session["devise.twitter_data"]

      if twitter_data
        @user = User.new(username: twitter_data.info.nickname, email: twitter_data.info.email, avatar: twitter_data.info.image, uid: twitter_data.uid, provider: twitter_data.provider)
      else
        @user = User.new
      end

    end

    ga_tracker.event(category: 'reg', action: 'start')
  end

  def create
    super

    if user_signed_in?
      ga_tracker.event(category: 'reg', action: 'complete', label: current_user.id)
    end
  end

  def update
    super

    if params[:is_onboarding] == 1
      flash[:success] = 'アカウント登録完了しました！最近こどもに聞かれた質問を投稿してみましょう！'
      redirect_to root_path
    end

    if params[:user][:is_question_form] == "1"

      respond_to do |format|
        format.js
      end
    end
  end
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_sign_up_path_for(resource)
    onboarding_index_path
  end
end
