class Utils

  def self.seconds_to_string(s)

    # d = days, h = hours, m = minutes, s = seconds
    m = (s / 60).floor
    s = s % 60
    h = (m / 60).floor
    m = m % 60
    d = (h / 24).floor
    h = h % 24

    output = "#{m} minute#{Utils.pluralize(m)}" if (m > 0)
    output = "#{h} hour#{Utils.pluralize(h)}, #{m} minute#{Utils.pluralize(m)}" if (h > 0)
    output = "#{d} day#{Utils.pluralize(d)}, #{h} hour#{Utils.pluralize(h)}, #{m} minute#{Utils.pluralize(m)}" if (d > 0)

    return output
  end

  def self.pluralize number
    return "s" unless number == 1
    return ""
  end

end