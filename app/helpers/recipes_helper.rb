module RecipesHelper
  def preparation_time_format(recipe)
    hours, minutes = recipe.split(':').map(&:to_i)

    hours_str = pluralize(hours, 'Hour') unless hours.zero?
    minutes_str = pluralize(minutes, 'Minute') unless minutes.zero?

    [hours_str, minutes_str].compact.join(' ').presence || "0 Minutes"
  end
end