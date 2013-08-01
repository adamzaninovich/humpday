require 'humpday/version'

module Humpday

  class UnknownSoundError < ArgumentError; end

  SOUNDS = {
    'uhoh'            => 'uhoh',
    'guess_what_day'  => 'guess_what_day_it_is',
    'guess_what_day_2'=> 'guess_what_day_it_is2',
    'huh'             => 'huh_anybody',
    'cmon'            => 'aw_cmon_i_know_you_can_hear_me',
    'laugh'           => 'laugh',
    'whoowhoa'        => 'whoowhoa',
    'humpday'         => 'humpday'
  }

  def self.play name
    sound_name = self.fuzzy_find name
    raise UnknownSoundError if sound_name.nil?    
    sound = SOUNDS.fetch(sound_name) { raise UnknownSoundError }
    audio_file = File.expand_path("../../lib/support/#{sound}.m4a", __FILE__)
    Sounder.play audio_file
  end

  def self.random
    self.play SOUNDS.keys.sample
  end

  def self.usage
    [ "humpday version #{Humpday::VERSION}",
      "Usage: humpday help (this)",
      "Usage: humpday random (picks a random sound)",
      "Usage: humpday <sound name> (it will fuzzy match the name)",
      "Sounds:",
      "  uhoh",
      "  guess_what_day",
      "  guess_what_day_2",
      "  huh",
      "  cmon",
      "  laugh",
      "  whoowhoa",
      "  humpday"
    ].join "\n"
  end
  
  private
  def self.fuzzy_find name
    SOUNDS.keys.select { |sn| sn.include? name }.first
  end
end
