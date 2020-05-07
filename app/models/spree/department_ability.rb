class Spree::DepartmentAbility
  include CanCan::Ability

  def initialize(user)  
    if user.respond_to?(:has_spree_role?) && user.has_spree_role?('admin')
      apply_department_permissions
    end
  end

  private    

  def apply_department_permissions
    can :manage, Spree::Department
  end

end