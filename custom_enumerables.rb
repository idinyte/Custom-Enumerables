module Enumerable
  UNDEFINED = Object.new

  def my_each
    return to_enum(:my_each) unless block_given?

    for i in self
      yield i
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = -1
    for i in self
      index += 1
      yield i, index
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    select = []
    my_each { |i| select << i if yield(*i) }
    instance_of?(Hash) ? Hash[*select.flatten(1)] : select
  end

  def my_all?(arg = UNDEFINED)
    is_class = arg.instance_of?(Class)
    boolean = if block_given?
                my_each { |item| return false unless yield(*item) }
              else
                my_each { |item| return false unless is_class && item.class <= arg || !is_class && item === arg }
              end
    boolean != false
  end

  def my_none?(arg = UNDEFINED)
    is_class = arg.instance_of?(Class)
    boolean = if block_given?
                my_each { |item| return false if yield(*item) }
              else
                my_each { |item| return false if is_class && item.class <= arg || !is_class && item === arg }
              end
    boolean != false
  end

  def my_count(arg = UNDEFINED)
    count = 0
    if block_given?
      my_each { |item| count += 1 if yield(*item) }
    elsif arg.equal?(UNDEFINED)
      count = size
    else
      my_each { |item| count += 1 if item === arg }
    end
    count
  end

  def my_map(&block)
    return unless block_given?

    array = []
    my_each { |i| array << block.call(i) }
    array
  end

  def my_inject(acc = UNDEFINED, &block)
    arr = instance_of?(Range) ? to_a : self
    if block_given?
      if acc.equal?(UNDEFINED)
        acc = arr[0]
        for i in 1..arr.size-1
          acc = block.call(acc, arr[i])
        end
      else
        for i in 0..arr.size-1
          acc = block.call(acc, arr[i])
        end
      end
    elsif acc.instance_of?(Symbol)
      block = acc.to_proc
      acc = arr[0]
      for i in 1..arr.size-1
        acc = block.call(acc, arr[i])
      end
    end
    acc
  end
end
