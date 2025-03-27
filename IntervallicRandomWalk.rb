# Starting from a reference pitch, this script will start a random walk
# by choosing among a collection of interval sizes.
# The walk will take a number of steps before a new walk is started by going back to the reference pitch.
# Your goal is to keep track of the pitches being visited.
# You can take a rest between consecutive walks.

# Change the random seed to take a different walk
use_random_seed 0

# Set the pitch range
$min_pitch = :F3
$max_pitch = :F4

# Set the reference pitch
# making sure it's within the pitch range above
ref = :C4

# Set the interval sizes (in semitones) making sure they fit within the pitch range above.
$int_sizes = [1,2]

# Set the steps of your walk
# before another walk is played.
max_steps = 3

# Set the duration of each step in seconds
step_duration = 1

# Set the waiting time between consecutive walks in seconds
waiting_time = 0

# Now you can run the script

$int_signs = [-1,1]

def step(pitch)
  size = $int_sizes.select{|s| pitch + s <= $max_pitch.to_i or pitch - s >= $min_pitch.to_i}.choose
  sign = $int_signs.choose
  if pitch+sign*size>$max_pitch.to_i or pitch+sign*size<$min_pitch.to_i
    sign = -1*sign
  end
  return pitch + sign*size
end

loop do
  steps = [ref]
  max_steps.times {
    steps = steps.concat([step(steps[steps.length-1])])
  }
  steps.each do |n|
    play n
    sleep step_duration
  end
  sleep waiting_time
end
