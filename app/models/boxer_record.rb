class BoxerRecord < ApplicationRecord
  belongs_to :boxer

  def total_fights
    boxer.fights_as_a.where(status: 'occurred').count + boxer.fights_as_b.where(status: 'occurred').count
  end
  
  validate :knockout_wins_cannot_exceed_wins
  validate :knockout_losses_cannot_exceed_losses

  def update_record_stats!
    record = calculate_record
    self.wins = record[:wins]
    self.losses = record[:losses]
    self.draws = record[:draws]
    self.knockout_wins = record[:knockout_wins]
    self.knockout_losses = record[:knockout_losses]
    save!
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

    knockout_wins = 0
    knockout_losses = 0

    # Check fights where boxer is boxer_a
    boxer.fights_as_a.where(status: 'occurred').each do |fight|
      if fight.winner_id == boxer.id
        wins += 1
        if fight.method == 'knockout'
          knockout_wins += 1
        end
      elsif fight.winner_id.nil? # Draw
        draws += 1
      else
        losses += 1
        if fight.method == 'knockout'
          knockout_losses += 1
        end
      end
    end

    # Check fights where boxer is boxer_b 
    boxer.fights_as_b.where(status: 'occurred').each do |fight|
      if fight.winner_id == boxer.id
        wins += 1
        if fight.method == 'knockout'
          knockout_wins += 1
        end
      elsif fight.winner_id.nil? # Draw
        draws += 1
      else
        losses += 1
        if fight.method == 'knockout'
          knockout_losses += 1
        end
      end
    end

    {wins: wins, losses: losses, draws: draws, knockout_wins: knockout_wins, knockout_losses: knockout_losses}
  end
end
