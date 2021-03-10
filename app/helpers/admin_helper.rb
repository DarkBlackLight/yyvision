module AdminHelper
  def setup_config
    {
      scope: 'vision',
      title: 'Vision Template',
      sessions: {
        authentication_key: 'username',
        title: 'Welcome To Vision',
        description: 'Vision Description',
        background: '/admin/images/background.jpg'
      }
    }
  end
end
