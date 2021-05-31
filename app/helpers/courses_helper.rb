module CoursesHelper
  def list_courses(courses)
    html_string = ''
    courses.each do |c|
      html_string << courses_html_template(c)
    end
    html_string.html_safe
  end

  def courses_html_template(course)
    "<a href='/courses/#{course.id}'>
      <div class='list-item'>
      #{add_icon(course)}
        <div class= 'list-text'>
          <b class= 'course-name text-secondary'> #{course.name} </b>
          <p class= 'course-date text-secondary'> #{course.created_at} </p>
        </div>
      <b class 'course-credit'> #{course.amount} hrs </b>
      </div>
    </a>
    "
  end

  def add_icon(course, size = '50')
    if course.groups.first
      if course.groups.first.icon == ''
        image_tag('https://via.placeholder.com/50', size: size, alt: "#{course.name} icon")
      else
        image_tag(course.groups.first.icon, size: size, alt: "#{course.name} icon")
      end
    else
      image_tag('https://via.placeholder.com/50', size: size, alt: 'un-groupped gift icon')
    end
  end

  def show_form
    if request.original_url.include?('groups')
      render 'group-form'
    else
      render 'form'
    end
  end
end
