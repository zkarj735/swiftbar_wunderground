#!/bin/zsh
# <bitbar.title>Weather Underground station weather</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Allister Jenks</bitbar.author>
# <bitbar.author.github>zkarj735</bitbar.author.github>
# <bitbar.desc>Fetches the temperature and humidity of a specific weather station from Weather Underground.</bitbar.desc>
# <bitbar.dependencies>curl</bitbar.dependencies>
# <bitbar.abouturl>http://github.com/zkarj735/</bitbar.abouturl>
# <swiftbar.schedule>*/15 * * * *</swiftbar.schedule>

# You must provide your own API key which can only be obtained if you have a Weather
# Underground account for your own Personal Weather Station (PWS). See your account
# page for details.
APIKEY='AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'

# The Weather Underground station ID you wish to display values from. Most usefully this
# will be your own station, but any station ID will work.
STATIONID='NZWN'

# The units to use for temperature display:
#  m = metric, i.e. the "one true" unit, Celsius (sorry Casey).
#  e = english, i.e. Fahrenheit.
UNITS='m'

# The colours to use for the thermometer symbol (SCOLOUR) and readouts (RCOLOUR) in
# standard CSS/hex format
SCOLOUR='#6699ff'
RCOLOUR='#33ddff'

# Here's where the magic happens...
curl -s "https://api.weather.com/v2/pws/observations/current?\
stationId=$STATIONID&format=json&units=$UNITS&apiKey=$APIKEY" \
 | sed -E -e 's/[][{}"]//g' \
          -e "s/^.+humidity:([0-9]+).+temp:([0-9]+).+/\
             :thermometer: \2º \1% | color=$RCOLOUR sfcolor=$SCOLOUR/"
