class BirdsController < ApplicationController
  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = Bird.find_by(id: params[:id])
    if bird
      render json: bird
    else
      render json: { error: 'Bird not found' }, status: :not_found
    end
  end

  # PUT/PATCH /birds/:id

  def update
    bird = Bird.find_by(id: params[:id])
    if bird
      bird.update(bird_params)
      render json: bird, status: :accepted
    else
      render json: { error: 'Bird not found' }, status: :not_found
    end
  end

  # handling bird likes
  def increment_likes
    bird = Bird.find_by(id: params[:id])
    if bird
      bird.update(likes: bird.likes + 1)
      render json: bird
    else
      render json: { error: 'Bird not found' }, status: :not_found
    end
  end
  # A note on breaking convention: by creating this custom route, we are breaking the REST conventions we had been following up to this point. One alternate way to structure this kind of feature and keep our routes and controllers RESTful would be to create a new controller, such as Birds::LikesController, and add an update action in this controller. The creator of Rails, DHH, advocates for this approach for managing sub-resourcesLinks to an external site..

  private

  def bird_params
    params.permit(:name, :species, :likes)
  end
end
