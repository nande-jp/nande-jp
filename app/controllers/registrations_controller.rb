class RegistrationsController < Devise::RegistrationsController
  def update
    super

    if params[:is_onboarding] == 1
      flash[:success] = 'アカウント登録完了しました！最近こどもに聞かれた質問を投稿してみましょう！'
      redirect_to root_path
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
