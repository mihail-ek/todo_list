class UsersController < ApplicationController

  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Todo list!"
      redirect_to @user
    else
      flash[:error] = "Error sign up user"
      render 'new'
    end
  end

  def edit
    @title = "Edit user"
    @user = User.find(current_user)
  end

  def show
    @title = "Project, task lists of "+current_user.name
    @projects = current_user.projects
    @task_lists = current_user.task_lists.where("project_id IS NULL")
  end

  def update
    @user = User.find(current_user)
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to '/profile'
    else
      @title = "Edit user"
      render 'edit'
    end
  end


  def destroy
    @user.destroy
    redirect_to users_path, :flash => { :success => "User destroyed." }
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

end