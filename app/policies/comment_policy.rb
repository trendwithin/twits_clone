class CommentPolicy < ApplicationPolicy

  def index?
  end

  def create?
    user.present? && (user.admin? || user.registered?)
  end

  def edit?
    user.present? && user.admin?
  end

  def update?
    edit?
  end

  def new?
    create?
  end

  def destroy?
    user.present? && user.admin?
  end

  def show?
    super && user.present? && (user.registered? || user.admin?)
  end
end
