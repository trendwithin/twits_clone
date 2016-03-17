class ChirpPolicy < ApplicationPolicy
  def create?
    user.present? && (user.admin? || user.registered?)
  end

  def destroy?
    user.present? && user.admin?
  end
end
