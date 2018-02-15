module  Pagination
  def page
    @page ||= params[:page] || 1
  end

  def per_page
    @per_page ||= params[:per_page] || 5
  end

  def paginate(collection)
    {
      current_page:  collection.current_page,
      next_page:     collection.next_page,
      previous_page: collection.prev_page,
      total_pages:   collection.total_pages,
      per_page:      collection.limit_value,
      total_records: collection.total_count
    }
  end
end