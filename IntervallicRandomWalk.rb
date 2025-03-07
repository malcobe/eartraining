# Starting from a reference pitch, this script will start a random walk
# by choosing among a collection of interval sizes.
# The walk will take a number of steps before it goes back to the reference pitch.
# Your goal is to keep track of the pitches visited, by recognizing
# the intervals being used.

# Change the random seed to take a different walk
use_random_seed 0

# Set up the pitch range
$min_pitch = :F3
$max_pitch = :F4

# Set up the reference pitch
# making sure it's within the pitch range above
ref = :C4

# Set up the interval sizes (in semitones) you'd like to practice on
# making sure they fit within the pitch range above
# starting from the central pitches of that range.
$int_sizes = [1,2]

# Set up the steps of your walk
# before you go back to your reference pitch.
max_steps = 2

# Now you can run the script

$int_signs = [-1,1]

def step(pitch)
  sign = $int_signs.choose
  size = $int_sizes.choose
  if pitch+sign*size>$max_pitch.to_i or pitch+sign*size<$min_pitch.to_i
    sign = -1*sign
  end
  return pitch + sign*size
end

pitch1 = ref
steps = 1
loop do
  pitch2 = step(pitch1)
  2.times {
    play pitch1
    sleep 1
  }
  2.times {
    play pitch2
    sleep 1
  }
  play pitch1
  sleep 4
  if steps < max_steps
    pitch1 = step(pitch1)
    steps = steps + 1
  else
    pitch1 = ref
    steps = 1
  end
end
