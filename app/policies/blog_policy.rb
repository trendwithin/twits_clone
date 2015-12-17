class BlogPolicy < ApplicationPolicy

  def index?
    user.present?
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
    super && user.present?
  end
end
