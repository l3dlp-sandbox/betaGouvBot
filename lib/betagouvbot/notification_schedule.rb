# encoding: utf-8
# frozen_string_literal: true

module BetaGouvBot
  module NotificationSchedule
    module_function

    class << self
      def call(members, terms, date)
        end_dates = terms.map { |term| date + term }

        members
          .map    { |member| member.merge(end: date_with_default(member[:end])) }
          .select { |member| end_dates.include? member[:end] }
          .map    { |member| { term: (member[:end] - date).to_i, who: member } }
      end

      private

      def date_with_default(date_string)
        Date.iso8601(date_string)
      rescue
        Date.iso8601('3017-01-01')
      end
    end
  end
end
