module RepositoriesHelper
  def p(links)
    page_hash = {}
    links = links.split(",")
    links.each do |link|
      page = link.match(/\=(\d+)\>/)[1]
      key = link.split("rel=")[1].match(/\w+/)[0]
      page_hash[key] = page
    end
    page_hash
  end

  def current_page
    if p(@links)['next']
      current_page = p(@links)['next'].to_i - 1
    else
      current_page = p(@links)['prev'].to_i + 1
    end
    "#{current_page}/#{p(@links)['last']}"
  end

  def p_avail?(str)
    p(@links)[str].present?
  end
end
