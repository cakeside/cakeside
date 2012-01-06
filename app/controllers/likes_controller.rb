class LikesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_creation
  # GET /likes
  # GET /likes.json
  def index
    # @likes = Like.all
    @likes = @creation.likes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @likes }
    end
  end

  # GET /likes/1
  # GET /likes/1.json
  def show
    # @like = Like.find(params[:id])
    @like = @creation.likes.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @like }
    end
  end

  # GET /likes/new
  # GET /likes/new.json
  def new
    @like = Like.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @like }
    end
  end

  # GET /likes/1/edit
  def edit
    @like = @creation.likes.find(params[:id])
    # @like = Like.find(params[:id])
  end

  # POST /likes
  # POST /likes.json
  def create
    # @like = Like.new(params[:like])
    @like = @creation.likes.create(params[:like])
    @like.user_id = current_user.id

    respond_to do |format|
      if @like.save
        format.html { redirect_to @creation, notice: 'Like was successfully created.' }
        format.json { render json: @like, status: :created, location: @like }
      else
        format.html { render action: "new" }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /likes/1
  # PUT /likes/1.json
  def update
    # @like = Like.find(params[:id])
    @like = @creations.likes.find(params[:id])

    respond_to do |format|
      if @like.update_attributes(params[:like])
        format.html { redirect_to @like, notice: 'Like was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    # @like = Like.find(params[:id])
    @like = @creation.likes.find(params[:id])
    @like.destroy

    respond_to do |format|
      format.html { redirect_to likes_url }
      format.json { head :ok }
    end
  end

  private
  def find_creation
    @creation = current_user.creations.find(params[:creation_id])
    raise ActiveRecord::RecordNotFound unless @creation
  end
end
