require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  fixtures :all
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["peter@gm.co"], mail.to
    assert_equal ["depot@example.co"], mail.from
    #assert_match "/1 x Ruby programming/", mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["peter@gm.co"], mail.to
    assert_equal ["depot@example.co"], mail.from
    #assert_match "/<td>1&times;<\/td>\s*<td>Ruby programming <\/td>/", mail.body.encoded
  end

end
