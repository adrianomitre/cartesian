module Iterable
  def restart
    @next_index = -1
    self
  end

  def next
    restart unless defined? @next_index
    raw_next
  end

  def raw_next
    raise RangeError, 'there is no next element, please restart' if done?
    self[@next_index += 1]
  end

  def restart_and_raw_next
    self[@next_index = 0]
  end

  # TODO: consider a module inclusion time solution to "count rescue size", for performance sake
  def done?
    @next_index && (@next_index == (count rescue size)-1)
  end
end
