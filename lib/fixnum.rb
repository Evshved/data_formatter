class Fixnum
  def ordinalize
    if (11..13).include?(abs % 100)
      "#{self}th"
    else
      case abs % 10
      when 1; "#{self}st"
      when 2; "#{self}nd"
      when 3; "#{self}rd"
      else    "#{self}th"
      end
    end
  end

  def ordinalize
    
    return "#{self}th" if (11..13).cover?(abs % 100)
    case abs % 10
    when 1 then "#{self}st"
    when 2 then "#{self}nd"
    when 3 then "#{self}rd"
    else "#{self}th"
    end
  end
end
