class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    record == user || user.admin?  #user can update their own profile, admins can update any profile
  end

  def destroy?
    user.admin?  #admins can delete users
  end
end
