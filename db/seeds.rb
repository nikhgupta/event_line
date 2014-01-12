# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

langs = { 'af' => "Afrikaans", 'ar' => "Arabic (beta)", 'bg' => "Bulgarian",
  'ca' => "Catalan", 'cz' => "Czech", 'da' => "Danish", 'de' => "German / Deutsch",
  'el' => "Greek", 'en' => "English", 'es' => "Spanish", 'eu' => "Basque/ Euskara",
  'fi' => "Finnish", 'fo' => "Faroese", 'fr' => "French", 'gl' => "Galician",
  'hu' => "Hungarian", 'hy' => "Armenian", 'id' => "Indonesian", 'is' => "Icelandic",
  'it' => "Italian", 'iw' => "Hebrew (beta)", 'ja' => "Japanese", 'ka' => "Georgian",
  'ko' => "Korean", 'lv' => "Latvian", 'nl' => "Dutch", 'no' => "Norwegian",
  'pl' => "Polish", 'pt-br' => "Brazilian Portuguese", 'pt' => "Portuguese",
  'ru' => "Russian", 'sk' => "Slovak", 'sl' => "Slovenian", 'sr-cy' => "Serbian (Cyrillic)",
  'sr' => "Serbian (Latin)", 'sv' => "Swedish", 'ta' => "Tamil", 'tl' => "Tagalog",
  'tr' => "Turkish", 'zh-cn' => "Chinese", 'zh-tw' => "Taiwanese"
}.each { |code, name| Language.find_or_create_by code: code, name: name }

maptypes = {
  stamen: %w[ toner toner-lines toner-labels watercolor sterrain ],
  google: %w[ ROADMAP TERRAIN HYBRID SATELLITE ]
}.each do |kind, names|
  names.each { |name| MapType.find_or_create_by name: name.downcase, kind: kind }
end

fonts = %w[ Arvo-PTSans Merriweather-NewsCycle PoiretOne-Molengo PTSerif-PTSans
DroidSerif-DroidSans Lekton-Molengo NixieOne-Ledger AbrilFatface-Average
PlayfairDisplay-Muli Rancho-Gudea Bevan-PotanoSans BreeSerif-OpenSans
SansitaOne-Kameron Pacifico-Arimo ].each { |font| Font.find_or_create_by name: font }
