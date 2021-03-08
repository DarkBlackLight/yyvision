module AdminHelper
  def setup_config
    {
      scope: 'admin',
      title: 'UFORSE CMS | UFORSE EDUCATION',
      sessions: {
        authentication_key: 'email',
        title: 'Welcome To UFORSE',
        description: '让天下学生走上适合自己的人生之路; Tutor Mentor Advisor; 导师, 老师, 规划师',
        background: '/admin/images/background.jpg'
      }
    }
  end
end
