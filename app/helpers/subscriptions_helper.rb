module SubscriptionsHelper
  def plan_description(plan)
    "(#{plan.rate.format} per #{ plan.interval==1 ? 'month' : pluralize(plan.interval, 'month')})" unless plan.free?
  end
end