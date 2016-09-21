class Array
  def my_uniq
    self.uniq
  end

  def two_sum
    answers = []

    self.each_with_index do |el, idx|
      idx2 = idx + 1
      while idx2 < self.length
        answers << [idx, idx2] if el + self[idx2] == 0
        idx2 += 1
      end
    end

    answers
  end
end

def my_transpose(array)
  array.transpose
end


def stock_picker(array)
  biggest_gap = 0
  start_index = nil
  end_index = nil
  array.each_with_index do |el, idx|
    (idx + 1...array.length).each do |idx2|
      if array[idx2] - el > biggest_gap
        biggest_gap = array[idx2] - el
        start_index = idx
        end_index = idx2
      end
    end
  end
  [start_index, end_index]
end
