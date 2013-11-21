module Issues

  module ApplicationHelper

    def gts_form_for(object, *args, &block)
      options = args.extract_options!
      (options[:html] ||= {}).update(:class => 'form-horizontal')
      form_args = args << options.merge(builder: FormBuilder)
      form_for(object, *form_args, &block)
    end
  end

end
