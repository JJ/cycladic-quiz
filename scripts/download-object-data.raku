#!/usr/bin/env raku

use JSON::Fast;
use LWP::Simple;

my %object-data = from-json slurp( "data/cycladic-objects.json" );

my @objects = %object-data<objectIDs>;

say @objects;