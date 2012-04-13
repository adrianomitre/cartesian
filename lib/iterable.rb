module Iterable
  def restart
    @next_index = -1
    true
  end

  def next
    restart unless defined? @next_index
    raw_next
  end

  def raw_next
    self[@next_index += 1]
  end

  def restart_and_raw_next
    self[@next_index = 0]
  end
end

