class TutorialsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
    @tutorials = Tutorial.all
  end

  def show
    @tutorial = Tutorial.find(params[:id])
  end

  def new
    @tutorial = Tutorial.new
  end

  def edit
    @tutorial = current_user.tutorials.find(params[:id])
  end

  def create
    @tutorial = current_user.tutorials.create(params[:tutorial])
    respond_to do |format|
      if @tutorial.save
        format.html { redirect_to( '/tutorials/' ) }
      else
        flash[:error] = @tutorial.errors.full_messages
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @tutorial = current_user.tutorials.find(params[:id])

    respond_to do |format|
      if @tutorial.update_attributes(params[:tutorial])
        format.html { redirect_to(@tutorial, :notice => 'tutorial was successfully updated.') }
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
