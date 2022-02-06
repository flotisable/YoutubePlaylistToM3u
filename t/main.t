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

is-deeply( $urlOutHandle.lines.list,        @refLines, 'parse download using youtube-dl'  );
is-deeply( $ytdlFileOutHandle.lines.list,   @refLines, 'parse youtube-dl json'            );
is-deeply( $ytdlpFileOutHandle.lines.list,  @refLines, 'parse yt-dlp json'                );

subtest 'Error Handling' =>
{
  my %tests = (
                'ytdl exec can not execute' =>
                  {
                    result    =>  run( "raku", $exec, '--ytdlExec=ab', 'ab', :out ).out.lines.list,
                    expected  =>  (
                                    "Program 'ab' can not be executed!",
                                  ),
                  },
                'ytdl exec run fail' =>
                  {
                    result    =>  run( "raku", $exec, 'ab', :out ).out.lines.list,
                    expected  =>  (
                                    "Fail in running youtube-dl!",
                                    "[youtube-dl Error Message]",
                                    'ERROR: \'ab\' is not a valid URL. Set --default-search "ytsearch" (or run  youtube-dl "ytsearch:ab" ) to search YouTube',
                                  ),
                  }
              );

  for %tests.kv -> $test, %info
  {
    is-deeply( %info<result>, %info<expected>, $test );
  }
}
done-testing;
