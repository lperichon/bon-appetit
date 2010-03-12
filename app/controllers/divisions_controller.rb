class DivisionsController < UserApplicationController
  layout nil
  def index
    search_options = {
      'level' => 1,
    }.merge(params[:search])
    search_options[:country_id] = 0 if search_options[:country_id].blank?
    @field_dom_id = params['field_dom_id']
    @level = Integer(search_options['level'])
    @search = Division.search(search_options)
    if params[:search]
      @divisions = @search.all
    else
      @divisions = []
    end
  end
end