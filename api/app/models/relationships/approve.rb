class Relationships::Approve < Relationship
  validate :validate_current_user_involved, unless: :already_approved
  validate :validate_previously_pending,    unless: :already_approved
  validate :validate_not_requesting_user,   unless: :already_approved

  before_update :restore_attributes, if: :already_approved

  private

    def already_approved
      status_was == "approved"
    end

    def validate_current_user_involved
      unless [user_one_id, user_two_id].include?(action_user_id)
        errors.add(:base, :current_user_uninvolved, message: "Only user_one or user_two can modify this relationship.")
      end
    end

    def validate_previously_pending
      unless status == "approved" && status_was == "pending"
        errors.add(:status, :status_must_be_pending, message: "User can only approve a pending relationship.")
      end
    end

    def validate_not_requesting_user
      if (action_user_id == action_user_id_was)
        errors.add(:base, :wrong_user_attempted_accept, message: "User can't approve a relationship they requested.")
      end
    end
end
