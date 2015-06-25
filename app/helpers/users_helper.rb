module UsersHelper
  def edit_profile_link(user:)
    return link_to t('user.edit.link'), edit_user_path(@user) if
      can_edit?(user: @user)
    ''
  end

  def can_edit?(user:)
    return current_user && current_user.id.to_s == @user.id.to_s
  end
end
