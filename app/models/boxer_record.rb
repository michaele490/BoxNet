class BoxerRecord < ApplicationRecord
  belongs_to :boxer

  def total_fights
    boxer.fights_as_a.where(status: 'occured').count + boxer.fights_as_b.where(status: 'occured').count
  end
  
  validate :knockout_wins_cannot_exceed_wins
  validate :knockout_losses_cannot_exceed_losses

  def update_record_stats!
    record = calculate_record
    self.wins = record[:wins]
    self.losses = record[:losses]
    self.draws = record[:draws]
    save!
  end

  private

  def knockout_wins_cannot_exceed_wins
    if knockout_wins && wins && knockout_wins > wins
      errors.add(:knockout_wins, "cannot be greater than total wins")
    end
  end

  def knockout_losses_cannot_exceed_losses
    if knockout_losses && losses && knockout_losses > losses
      errors.add(:knockout_losses, "cannot be greater than total losses") 
    end
  end

  def calculate_record
    wins = 0
    losses = 0
    draws = 0

    # Check fights where boxer is boxer_a
    boxer.fights_as_a.where(status: 'occured').each do |fight|
      if fight.winner_id == boxer.id
        wins += 1
      elsif fight.winner_id.nil? # Draw
        draws += 1
      else
        losses += 1
      end
    end

    # Check fights where boxer is boxer_b 
    boxer.fights_as_b.where(status: 'occured').each do |fight|
      if fight.winner_id == boxer.id
        wins += 1
      elsif fight.winner_id.nil? # Draw
        draws += 1
      else
        losses += 1
      end
    end

    {wins: wins, losses: losses, draws: draws}
  end

  def wins
    calculate_record[:wins]
  end

  def losses 
    calculate_record[:losses]
  end

  def draws
    calculate_record[:draws]
  end
  
end
