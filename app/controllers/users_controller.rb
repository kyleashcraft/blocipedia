require 'rails_helper'

class UsersController < ApplicationController

  def downgrade
    @user = current_user
    @user.update(role: "standard")
    puts "From controller"
    p @user
    binding.pry
    p Wiki.where(user_id: @user.id)
    if @user.downgrade_wikis
      flash["You have been downgraded to standard."]
      redirect_to root_path
    else
      flash.now["Error downgrading account, please try again."]
    end

    puts "\n \n"
  end

end
