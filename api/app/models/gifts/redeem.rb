class Gifts::Redeem < Gift
  validates_presence_of :published_at
  validate :validate_previously_requested

  private
    def validate_previously_requested
      unless status == "redeemed" && status_was == "requested"
        errors.add(:status, :status_must_be_requested, message: "User can only redeem previously requested gifts. Previous status was: #{status_was}.")
      end
    end
end
