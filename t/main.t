#!/usr/bin/raku
use Test;

my Str $exec        = "youtubePlaylistToM3u.raku";
my Str $refPlaylist = "t/golden/rebornPlaylist.txt";
my %defaults        = (
                        ytdlFile  => "playlist.json",
                        ytdlpFile => "playlist_ytdlp.json",
                        url       => "https://www.youtube.com/playlist?list=PLcMKHw1SCSYyqOrTLthgY87q-lFu7o5ER",
                      );

my IO::Handle $refOutHandle       = $refPlaylist.IO.open( :r );
my IO::Handle $urlOutHandle       = run( "raku", $exec, "%defaults<url>",                               :out ).out;
my IO::Handle $ytdlFileOutHandle  = run( "raku", $exec, "-f=%defaults<ytdlFile>",                       :out ).out;
my IO::Handle $ytdlpFileOutHandle = run( "raku", $exec, "--ytdlExec=ytdlp", "-f=%defaults<ytdlpFile>",  :out ).out;
my @refLines := $refOutHandle.lines.list;

ok( $urlOutHandle.lines.list       eqv @refLines );
ok( $ytdlFileOutHandle.lines.list  eqv @refLines );
ok( $ytdlpFileOutHandle.lines.list eqv @refLines );

done-testing;
