module CoursesHelper
  def list_courses(courses)
    html_string = ''
    courses.each do |c|
      html_string << courses_html_template(c)
    end
    html_string.html_safe
  end

  def courses_html_template(course)
    "<div class=' p-2 container'>
      <div class=' bg-white border text-center mx-auto'>
        <a href='/courses/#{course.id}' class='text-dark'>
          <div class=' row p-3'>
            <div class='col-3'>
              #{add_course_icon(course)}
            </div>
            <div class= 'list-text col-6 text-left'>
              <div class=' mt-2 container'>
                <b class= 'course-name text-secondary row'> #{course.name} </b>
                <br>
                <b class= 'course-date text-muted small row align-items-end'>
                #{course.created_at.strftime('%d %b %Y')}
                </b>
              </div>
            </div>
            <div class='course-credit col-3 mt-2 float-right'>
              <b> #{course.amount} hrs </b>
            </div>
          </div>
        </a>
      </div>
    </div>
    "
  end

  def add_course_icon(course, size = '75')
    if course.group.nil?
      image_tag('https://via.placeholder.com/75', size: size, alt: 'un-groupped gift icon')
    elsif course.group.icon.nil?
      image_tag('https://via.placeholder.com/75', size: size, alt: "#{course.name} icon")
    else
      image_tag(course.group.icon, size: size, alt: "#{course.name} icon")
    end
  end
end
