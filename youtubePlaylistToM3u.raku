my Str $file = "playlist.json";

grammar JsonParser
{
  token TOP               { '{' <data>+ % ',' '}' }
  token data              { \s* <key> \s* ':' \s* <value> \s* }
  token key               { \" \w+ \" }
  proto token value       { * }
  token value:sym<string> { \" <-[ \" ]>+ \" }
  token value:sym<null>   { null }
  token value:sym<number> { \d+\.\d+ }
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
      make $<key>.made => $<value>.made;
    }
  }

  method key( $/ )
  {
    make $/.subst( '"', '', :g );
  }

  method value:sym<string>( $/ )
  {
    make $/.subst( '"', '', :g );
  }

  method value:sym<number>( $/ )
  {
    make +$/;
  }
}

say "#EXTM3U";

for $file.IO.lines -> $line
{
  my $data = JsonParser.parse( $line, actions => JsonParserAction.new ).made;

  $data<title> ~~ s:g/\\u(<[0..9a..e]> ** 4)/{ hexToDec( ~$0 ).chr }/; # turn \uxxxx string to unicode character
  say "#EXTINF:$data<duration>,$data<title>";
  say "https://www.youtube.com.watch?v=$data<url>";
}

sub hexToDec( Str $hex )
{
  my %digitTable = ( ( '0'...'9', 'a'...'f' ) Z ( 0...15 ) ).flat;

  my $dec = 0;
  my @hex = $hex.flip.split( '', :skip-empty );
  
  loop ( my $i = 0; $i < @hex.elems ; ++$i )
  {
    $dec += %digitTable{@hex[$i]} * 16 ** $i;
  }
  return $dec;
}
# vim: filetype=perl6
