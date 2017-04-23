class Game
  def initialize
    # Initially game score is set to 0
    @score = 0
    @throws = Array.new
    @total_throws = 0
  end

  def score
    score = 0
    throwIndex = 0

    for frame in 0..9
      if strike?(throwIndex)
        score += strike_score(throwIndex)
        throwIndex += 1
      elsif spare?(throwIndex)
        score += spare_score(throwIndex)
        throwIndex += 2
      else
        score += throw_score(throwIndex) + throw_score(throwIndex + 1)
        throwIndex += 2
      end
    end

    score
  end

  def current_frame
    frame = 1
    ball = 1

    @throws.each_with_index do |throw, index|
      # If less than 9 frames, make frames by either strikes or count ball throws
      if frame < 9
        if strike?(index)
          frame += 1
        elsif ball == 2
          frame += 1
          ball = 1
        else
          ball += 1
        end
      elsif frame == 9
        # If entering flow with 9 (and has at least one more throw cause it hit here)
        # then add one and mark the game done at 10 frames
        frame += 1
      end
    end

    frame
  end

  def current_ball
    (@total_throws % 2) + 1
  end

  # Throw ball for a current frame
  def throw_ball(score=0)
    @score += score
    @total_throws += 1
    @throws << score
  end

  private
  def strike?(index)
    throw_score(index) == 10
  end

  def spare?(index)
    throw_score(index) + throw_score(index+1) == 10
  end

  def throw_score(index)
    return 0 if @throws[index].nil?
    @throws[index]
  end

  # Return original 10 points and then combine points of next two ball rolls
  def strike_score(index)
    10 + throw_score(index+1) + throw_score(index+2)
  end

  # Return original 10 points and then combine points of next ball roll
  def spare_score(index)
    10 + throw_score(index+2)
  end
end
