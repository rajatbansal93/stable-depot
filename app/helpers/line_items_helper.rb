module LineItemsHelper

  def heading
    if @message
      @message
    else
      "Listing Line Items"
    end
  end

  def total_pages
    @line_items.size/5 + 1
  end

  def current_page_items(page_number = 0)
    @line_items.slice(page_number*5, 5)
  end
end
