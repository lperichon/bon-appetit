class CitiesController < UserApplicationController
  layout nil

  def index
    search_options = {
    }.merge(params[:search])
    search_options[:country_id] = 0 if search_options[:country_id].blank?
    @field_dom_id = params['field_dom_id']
    @search = City.search(search_options)
    if @search
      @cities = @search.all
    else
      @cities = []
    end
  end
end