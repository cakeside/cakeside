class TutorialsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
    @tutorials = Tutorial.page(params[:page]).per(15)
  end

  def show
    @tutorial = Tutorial.find(params[:id])
  end

  def new
    @tutorial = Tutorial.new
    @user = current_user
  end

  def edit
    @tutorial = current_user.tutorials.find(params[:id])
  end

  def create
    @tutorial = current_user.tutorials.create(params[:tutorial])
    current_user.tag(@tutorial, :with => params[:tutorial_tags], :on => :tags)
    respond_to do |format|
      if @tutorial.save
        format.html { redirect_to( '/tutorials', :notice => 'the tutorial was successfully added.' ) }
      else
        flash[:error] = @tutorial.errors.full_messages
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @tutorial = current_user.tutorials.find(params[:id])
    current_user.tag(@tutorial, :with => params[:tutorial_tags], :on => :tags)
    respond_to do |format|
      if @tutorial.update_attributes(params[:tutorial])
        format.html { redirect_to(@tutorial, :notice => 'the tutorial was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @tutorial = current_user.tutorials.find(params[:id])
    @tutorial.destroy

    respond_to do |format|
      format.html { redirect_to(tutorials_url) }
    end
  end
end
