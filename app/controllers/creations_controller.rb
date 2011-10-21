class CreationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  # GET /creations
  # GET /creations.xml
  def index
    @creations = Creation.page(params[:page]).per(6)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @creations }
    end
  end

  # GET /creations/1
  # GET /creations/1.xml
  def show
    @creation = Creation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @creation }
    end
  end

  # GET /creations/new
  # GET /creations/new.xml
  def new
    @creation = Creation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @creation }
    end
  end

  # GET /creations/1/edit
  def edit
    @creation = current_user.creations.find(params[:id])
  end

  # POST /creations
  # POST /creations.xml
  def create
    @creation = current_user.creations.create(params[:creation])
    @creation.category_ids = params[:creation][:category_ids] ||= []
    respond_to do |format|
      if @creation.save
        format.html { redirect_to(@creation, :notice => 'Creation was successfully created.') }
        format.xml  { render :xml => @creation, :status => :created, :location => @creation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @creation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /creations/1
  # PUT /creations/1.xml
  def update
    @creation = current_user.creations.find(params[:id])
    puts "creation is #{@creation.class}"
    @creation.category_ids = params[:creation][:category_ids] ||= []

    respond_to do |format|
      if @creation.update_attributes(params[:creation])
        format.html { redirect_to(@creation, :notice => 'Creation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @creation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /creations/1
  # DELETE /creations/1.xml
  def destroy
    @creation = current_user.creations.find(params[:id])
    @creation.destroy

    respond_to do |format|
      format.html { redirect_to(creations_url) }
      format.xml  { head :ok }
    end
  end

  def mine
    @creations = current_user.creations

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @creations }
    end
  end
end
