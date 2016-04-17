class TwitterRelationshipsController < ApplicationController
  before_action :set_twitter_relationship, only: [:show, :edit, :update, :destroy]

  # GET /twitter_relationships
  # GET /twitter_relationships.json
  def index
    @twitter_relationships = TwitterRelationship.all
  end

  # GET /twitter_relationships/1
  # GET /twitter_relationships/1.json
  def show
  end

  # GET /twitter_relationships/new
  def new
    @twitter_relationship = TwitterRelationship.new
  end

  # GET /twitter_relationships/1/edit
  def edit
  end

  # POST /twitter_relationships
  # POST /twitter_relationships.json
  def create
    @twitter_relationship = TwitterRelationship.new(twitter_relationship_params)

    respond_to do |format|
      if @twitter_relationship.save
        format.html { redirect_to @twitter_relationship, notice: 'Twitter relationship was successfully created.' }
        format.json { render :show, status: :created, location: @twitter_relationship }
      else
        format.html { render :new }
        format.json { render json: @twitter_relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /twitter_relationships/1
  # PATCH/PUT /twitter_relationships/1.json
  def update
    respond_to do |format|
      if @twitter_relationship.update(twitter_relationship_params)
        format.html { redirect_to @twitter_relationship, notice: 'Twitter relationship was successfully updated.' }
        format.json { render :show, status: :ok, location: @twitter_relationship }
      else
        format.html { render :edit }
        format.json { render json: @twitter_relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /twitter_relationships/1
  # DELETE /twitter_relationships/1.json
  def destroy
    @twitter_relationship.destroy
    respond_to do |format|
      format.html { redirect_to twitter_relationships_url, notice: 'Twitter relationship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_twitter_relationship
      @twitter_relationship = TwitterRelationship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def twitter_relationship_params
      params.require(:twitter_relationship).permit(:follower, :followed)
    end
end
