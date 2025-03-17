class CategoryPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def create?
      user.admin?  #only admins can create cat
    end
  
    def update?
      user.admin?  #only admins can update cat
    end
  
    def destroy?
      user.admin?  #only admins can delete cat
    end
  
    def index?
      true  #everyone can view cat
    end
  
    def assign_category?
      user.user?  #users can assign cat to their cc
    end
  
    def remove_category?
      record.credit_card.user == user  #users can only remove cat from their own cc
    end
  
    def update_points?
      record.credit_card.user == user  #users can only update points for their own cc
    end
  end
end
