require 'helper'

class MatcherTest < Test::Unit::TestCase

  should "raise an exception when using unknown operator" do
    operators = %w{ne mod all exists}
    operators.each do |op|
      assert_raise Exception do
        Process.where(:pid.send(op) => 1).all
      end
    end
  end

  should "accept $gt operator" do
    query = Process.where(:pid.gt => 1)
    assert query.count >= 1
  end

  should "accept $gte operator" do
    query = Process.where(:pid.gte => 1)
    assert query.count >= 1
  end

  should "accept $lt operator" do
    query = Process.where(:pid.lt => 2)
    assert query.count == 1
  end

  should "accept $lte operator" do
    query = Process.where(:pid.lte => 1)
    assert query.count == 1
  end

  should "accept $in operator" do
    query = Process.where(:pid.in => [1, 2])
    assert query.count >= 1
  end

  should "accept $nin operator" do
    query = Process.where(:pid.nin => [Process.pid])
    assert query.count > 0
  end

end
