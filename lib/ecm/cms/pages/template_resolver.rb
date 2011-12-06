class Ecm::Cms::Pages::TemplateResolver < ActionView::Resolver
  require "singleton"
  include Singleton
  
  def find_template_meta(name, prefix, partial, details)
    return if partial
    conditions = {
      :path    => normalize_path(name, prefix),
      :locale  => normalize_array(details[:locale]).first,
      :format  => normalize_array(details[:formats]).first,
      :handler => normalize_array(details[:handlers])
#      :handler => normalize_array(details[:handlers]),
#      :partial => partial || false
    }
    conditions.delete(:partial)
    format = conditions.delete(:format)
    query  = Ecm::Cms::Pages::CmsTemplate.where(conditions)

    # 2) Check for templates with the given format or format is nil
    query = query.where(["format = ? OR format IS NULL", format])

    # 3) Ensure templates with format come first
    query = query.order("format DESC")

    # 4) Now trigger the query passing on conditions to initialization
    template = query.first
    if template
      return template.title, template.meta_description
    else
      return "title", "meta_description"
    end  
  end

  def find_templates(name, prefix, partial, details)
    return if partial
    conditions = {
      :path    => normalize_path(name, prefix),
      :locale  => normalize_array(details[:locale]).first,
      :format  => normalize_array(details[:formats]).first,
      :handler => normalize_array(details[:handlers])
#      :handler => normalize_array(details[:handlers]),
#      :partial => partial || false
    }
    conditions.delete(:partial)
    format = conditions.delete(:format)
    query  = Ecm::Cms::Pages::CmsTemplate.where(conditions)

    # 2) Check for templates with the given format or format is nil
    query = query.where(["format = ? OR format IS NULL", format])

    # 3) Ensure templates with format come first
    query = query.order("format DESC")

    # 4) Now trigger the query passing on conditions to initialization
    query.map do |record|
      initialize_template(record, details)
    end
  end

  # Normalize name and prefix, so the tuple ["index", "users"] becomes
  # "users/index" and the tuple ["template", nil] becomes "template".
  def normalize_path(name, prefix)
    prefix.present? ? "#{prefix}/#{name}" : name
  end

  # Normalize arrays by converting all symbols to strings.
  def normalize_array(array)
    array.map(&:to_s)
  end

  # Initialize an ActionView::Template object based on the record found.
  def initialize_template(record, details)
    source     = record.body
    identifier = "SqlTemplate - #{record.id} - #{record.path.inspect}"
    handler    = ActionView::Template.registered_template_handler(record.handler)

    # 5) Check for the record.format, if none is given, try the template
    # handler format and fallback to the one given on conditions
    format   = record.format && Mime[record.format]
    format ||= handler.default_format if handler.respond_to?(:default_format)
    format ||= details[:formats]

    details = {
      :format => format,
      :updated_at => record.updated_at,
      :virtual_path => virtual_path(record.path, record.partial)
    }

    ActionView::Template.new(source, identifier, handler, details)
  end

  # Make paths as "users/user" become "users/_user" for partials.
  def virtual_path(path, partial)
    return path unless partial
    if index = path.rindex("/")
      path.insert(index + 1, "_")
    else
      "_#{path}"
    end
  end
end
