class BlogPolicy < ApplicationPolicy

  def index?
    user.present? && (user.registered? || user.admin?)
  end

  def create?
    user.present? && user.admin?
  end

  def edit?
    create?
  end

  def update?
    create?
  end

  def new?
    create?
  end

  def destroy?
    create?
  end

  def show?
    super && user.present? && (user.registered? || user.admin?)
  end
end
