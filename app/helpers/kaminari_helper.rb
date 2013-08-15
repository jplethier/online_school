module KaminariHelper
  def has_pagination_links?(collection)
    collection.total_pages > 1
  end
end
