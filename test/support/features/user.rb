module Features

  class User < SimpleDelegator
    attr_reader :user

    def initialize(user, context)
      super(context)
      @user = user
    end

    def sign_in
      visit new_sessions_path
      find('#email').set(user.email)
      find('#password').set('test')
      click_on 'Log in'
    end

    def create_issue(params = {})
      attributes = params.reverse_merge(:title => 'issue #1', :description => 'test issue')
      visit routes.new_project_issue_path(project)
      find('#issue_title').set(attributes[:title])
      find('#issue_description').set(attributes[:description])
      if params[:labels]
        params[:labels].each do |label|
          within('.issue-label-widget') do
            find('#issue_label').set(label)
            click_on 'Add'
          end
        end
      end
      click_on 'Save'
    end

    def create_label(params = {})
      visit routes.new_project_issue_label_path(project)

      attributes = params.reverse_merge(:name => 'feature', :color => 'green')

      find('#label_name').set(attributes[:name])
      find('#label_color').set(attributes[:color])

      click_on 'Save'
    end

    def create_milestone(params = {})
      visit routes.new_project_issue_milestone_path(project)

      attributes = params.reverse_merge(:name => 'v1.0')

      find('#milestone_name').set(attributes[:name])

      click_on 'Save'
    end

    def check_filter(name)
      find('label', :text => name).click
    end

  end

end
