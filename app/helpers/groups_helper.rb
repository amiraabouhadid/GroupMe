module GroupsHelper
  def list_groups(groups)
    html_string = ''
    groups.each do |g|
      html_string << groups_html_template(g)
    end
    html_string.html_safe
  end

  def groups_html_template(group)
    "<div class=' p-2 container'>
      <div class=' bg-white border text-center mx-auto'>
        <a href='/groups/#{group.id}' class='text-dark'>
          <div class=' row p-3'>
            <div class='col-3'>
              #{add_group_icon(group)}
            </div>
            <div class= 'list-text col-6 text-left'>
              <div class=' mt-2 container'>
                <b class= 'group-name text-secondary row'>
                #{group.name}
                </b>
                <br>
                <b class= 'group-date text-muted small row align-items-end'>
                #{group.created_at.strftime('%d %b %Y')}
                </b>
              </div>
            </div>
            <div class='group-credit col-3 mt-2 float-right'>
              <b> Courses: #{group.courses.count} </b>
            </div>
          </div>
        </a>
      </div>
    </div>
    "
  end

  def add_group_icon(group, size = '75')
    if group.nil?
      image_tag('https://via.placeholder.com/75', size: size, alt: 'un-grouped gift icon')
    elsif group.icon.nil?
      image_tag('https://via.placeholder.com/75', size: size, alt: "#{group.name} icon")
    else
      image_tag(group.icon, size: size, alt: "#{group.name} icon")
    end
  end
end
