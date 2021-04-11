#!/usr/bin/raku
use Test;

my Str $exec        = "youtubePlaylistToM3u.raku";
my Str $refPlaylist = "t/golden/rebornPlaylist.txt";
my %defaults        = (
                        file  => "playlist.json",
                        url   => "https://www.youtube.com/playlist?list=PLcMKHw1SCSYyqOrTLthgY87q-lFu7o5ER",
                      );

my IO::Handle $refOutHandle = $refPlaylist.IO.open( :r );
my IO::Handle $urlOutHandle = run( "raku", $exec, "%defaults<url>", :out ).out;

ok( ( $urlOutHandle.lines.list cmp $refOutHandle.lines.list ) == Order::Same );

done-testing;
# vim: filetype=perl6
