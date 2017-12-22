module Api
  module GiftError

    class InvalidUser < StandardError
      def initialize(msg="You can only add gifts to yourself and your friends.")
        super
      end
    end

    class InvalidAuthor < StandardError
      def initialize(msg="You can only modify gifts you've added.")
        super
      end
    end

  end
end
