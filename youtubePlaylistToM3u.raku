#!/usr/bin/raku
grammar JsonParser        { ... }
class   JsonParserAction  { ... }

sub MAIN(
  Str $playlistUrl?,  # = "https://www.youtube.com/playlist?list=PLcMKHw1SCSYyqOrTLthgY87q-lFu7o5ER",
  Str :o(:$output),
  Str :f(:$file),     # = "playlist.json",
  Str :$ytdlExec      = "youtube-dl",
)
{
  my IO::Handle $inputHandle  = getInputHandle( $ytdlExec, $playlistUrl, $file );
  my IO::Handle $outputHandle = $output ?? open( $output, :w ) !! $*OUT;

  $outputHandle.say( "#EXTM3U" );

  for $inputHandle.lines -> $line
  {
    my $data = JsonParser.parse( $line, actions => JsonParserAction.new ).made;

    $data<title> ~~ s:g/\\u(<[0..9a..f]> ** 4)/{ utf8IntStringToChar( ~$0 ) }/; # turn \uxxxx string to unicode character
    $outputHandle.say( "#EXTINF:$data<duration>,$data<title>" );
    $outputHandle.say( getUrl( "$data<url>", $ytdlExec )      );
  }
}

grammar JsonParser
{
  token TOP               { '{' <data>+ % ',' '}' }
  token data              { \s* <key> \s* ':' \s* <value> \s* }
  token key               { '"' \w+ '"' }
  proto token value       { * }
  token value:sym<string> { '"' ( [ <-[ " ]> | <?after '\\'> '"' ]+ ) '"' }
  token value:sym<null>   { null }
  token value:sym<number> { \d+[\.\d+]? }
  token value:sym<array>  { '[' <-[ \[\] ]>* ']' }
  token value:sym<object> { '{' <-[ \{\} ]>* '}' }
}

class JsonParserAction
{
  method TOP( $/ )
  {
    my %datas;

    for $<data> -> $data
    {
      next unless $data.made;

      %datas.push( $data.made );
    }
    make %datas;
  }

  method data( $/ )
  {
    if ( $<key>.made eq "title" | "duration" | "url" )
    {
      my $value = $<value>.made;

      $value = 0 if not $value.defined and $<key>.made eq "duration";

      make $<key>.made => $value;
    }
  }

  method key( $/ )
  {
    make $/.subst( '"', '', :g );
  }

  method value:sym<string>( $/ )
  {
    make $/[0].subst( '\\"', '"', :g );
  }

  method value:sym<number>( $/ )
  {
    make +$/;
  }
}

sub getInputHandle( Str $ytdlExec, Str $playlistUrl, Str $file )
{
  with $playlistUrl
  {
    if !run( $ytdlExec, "--version", :out, :err )
    {
      say   "Program '$ytdlExec' can not be executed!";
      exit 1;
    }
    my $proc = run( $ytdlExec, "--flat-playlist", "-j", $playlistUrl, :out, :err );

    if !$proc
    {
      say   "Fail in running $ytdlExec!";
      say   "[$ytdlExec Error Message]";
      print $proc.err.slurp;
      exit 1;
    }
    return $proc.out;
  }
  return open( $file, :r ) with $file;
  return $*IN;
}

# not support 2 bit unicode character now
sub utf8IntStringToChar( Str $numStr )
{
  my Int $num = $numStr.parse-base( 16 );

  return ( $num > 0xC000 ) ?? "" !! $num.chr;
}

sub getUrl( Str $url, Str $ytdlExec )
{
  return 'https://www.youtube.com/watch?v=' ~ $url if $ytdlExec ~~ /youtube\-dl/;
  return $url;
}
