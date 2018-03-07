class UsersController < ApplicationController

  def downgrade
    if current_user.standard_downgrade
      flash[:notice] = "User membership switched to standard. All private wikis are now public."
      redirect_to wikis_path
    else
      flash.now[:alert] = "Account downgrade failed"
    end
  end

end
