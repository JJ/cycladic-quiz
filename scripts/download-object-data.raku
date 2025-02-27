#!/usr/bin/env raku

use JSON::Fast;
use LWP::Simple;

my %object-data = from-json slurp( "data/cycladic-objects.json" );

my @objects = |%object-data<objectIDs>;

my %object-store;
for  @objects -> $objectID {
    my $object-data = LWP::Simple.get( "https://collectionapi.metmuseum.org/public/collection/v1/objects/$objectID" );

    if !$object-data {
        say "Failed to download object $objectID";
        next;
    }

    my %object = from-json $object-data;

    %object-store{$objectID} = {};
    for <primaryImage department objectName title culture period objectDate medium city region locale classification objectURL> -> $key {
        %object-store{$objectID}{$key} = %object{$key};
    }
    sleep 0.1;

}

spurt("data/object-store.json", to-json %object-store);