#!/bin/bash

# clear calcurse data
rm ~/.calcurse/apts

# array for remote calendars
calendars=( 'https://moseskonto.tu-berlin.de/moses/cal/export/5353dd495519c8f23584ddca4ba12588' );

# temp file to save a calendar
TMPCAL=/tmp/temp.ics

# run through the calendars
for ical in "${calendars[@]}"
do
    # download ical file
    wget -q "$ical" -O $TMPCAL
    # import into calcurse, error & output silenced
    calcurse -i $TMPCAL >/dev/null 2>&1
    # clear the temp calendar file
    rm $TMPCAL
done

# display current & next 6 days (7 altogether)
calcurse -r5
