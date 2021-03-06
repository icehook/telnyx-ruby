# frozen_string_literal: true

require_relative "../test_helper"

module Telnyx
  class SimCardTest < Test::Unit::TestCase
    should "retrieve sim card" do
      sim = Telnyx::SimCard.retrieve "123"
      assert_requested(:get, "#{Telnyx.api_base}/v2/sim_cards/123")
      assert_kind_of Telnyx::SimCard, sim
    end

    should "list sim cards" do
      simlist = Telnyx::SimCard.list
      assert_requested(:get, "#{Telnyx.api_base}/v2/sim_cards")
      assert_kind_of Telnyx::ListObject, simlist
    end

    should "save sim card" do
      sim = Telnyx::SimCard.retrieve "123"
      sim.save
      assert_requested(:get, "#{Telnyx.api_base}/v2/sim_cards/123")
    end

    should "register sim card" do
      Telnyx::SimCard.register(registration_codes: %w[1234567890 123456332601])
      assert_requested(:post, "#{Telnyx.api_base}/v2/actions/register/sim_cards")
    end

    context "actions" do
      should "deactivate" do
        sim = Telnyx::SimCard.retrieve "123"
        sim.deactivate
        assert_requested(:post, "#{Telnyx.api_base}/v2/sim_cards/#{sim.id}/actions/deactivate")
      end

      should "activate" do
        sim = Telnyx::SimCard.retrieve "123"
        sim.activate
        assert_requested(:post, "#{Telnyx.api_base}/v2/sim_cards/#{sim.id}/actions/activate")
      end
    end
  end
end
