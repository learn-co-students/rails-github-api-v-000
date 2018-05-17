module RepositoriesHelper
  def display_repos(json)
    html = '<ul>'
    json.each do |repo|
      html += content_tag(:li, link_to(repo["name"], repo["html_url"]))
    end
    html += '</ul>'
  end
end
