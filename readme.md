# Youtube Playlist To M3u
  Convert youtube playlist url to m3u file

## Requirement
   - [youtube-dl](https://github.com/ytdl-org/youtube-dl)

## Motivation
   I sometimes use **mpv** to play the faverite music playlist of my youtube account,
   and the m3u file need to be updated manually to sync with the playlist.
   Recently, I want to add new playlist for other types of music and I also start learning [Raku](https://www.raku.org/),
   so I decide to write a sciprt to do that with the language.

   This script is written for the following purpose:
   - update m3u file with script rather than manually
   - practice the **Raku** programming language
     - especially try the **grammar** build in Raku

## Usage
   The script can be used by giving one of the following
   - the youtube playlist url
     - though positional argument
   - the json output from ```youtube-dl --flat-playlist -j```
     - though ```-f``` option
     - or from stdin

   The output will be printed out to stdout,
   or we can use ```-o``` option to write to a file.
   Note that output to stdout can produce garbled characters in **#EXTINF** line if the title of video uses unicode and the shell encoding is not unicode.

## Example
   ```
   shell> raku youtubePlaylistToM3u.raku "https://www.youtube.com/playlist?list=PLcMKHw1SCSYyqOrTLthgY87q-lFu7o5ER"
   #EXTM3U
   #EXTINF:280,【家庭教師Reborn!】DIVE TO WORLD 【中日字幕】
   https://www.youtube.com/watch?v=HYB8x17Ijl4
   #EXTINF:219,【家庭教師Reborn!】EASY GO 【中日字幕】
   https://www.youtube.com/watch?v=4b6Y9huuOEE
   #EXTINF:275,【家庭教師Reborn!】last cross 【中日字幕】
   https://www.youtube.com/watch?v=F4qazr5HQ9k
   #EXTINF:247,【家庭教師Reborn!】すべり台【中日字幕】
   https://www.youtube.com/watch?v=0n9P2WrOfF8
   #EXTINF:270,【家庭教師Reborn!】アメあと 【中日字幕】
   https://www.youtube.com/watch?v=zIz85dwehIg
   #EXTINF:237,【家庭教師Reborn!】ファミリア【中日字幕】
   https://www.youtube.com/watch?v=qs20sdId6xU
   #EXTINF:266,【家庭教師Reborn!】桜ロック 【中日字幕】
   https://www.youtube.com/watch?v=-ykRO_IWbXs
   #EXTINF:249,【家庭教師Reborn!】CYCLE【中日字幕】
   https://www.youtube.com/watch?v=_W6bRS8nFqM
   #EXTINF:243,【家庭教師Reborn!】キャンバス 【中日字幕】
   https://www.youtube.com/watch?v=uTR03cPqf98
   #EXTINF:235,【家庭教師Reborn!】88 【中日字幕】
   https://www.youtube.com/watch?v=M2sws0PGdJg
   #EXTINF:248,【家庭教師Reborn!】BOYS & GIRLS 【中日字幕】
   https://www.youtube.com/watch?v=rmY_aySF90E
   #EXTINF:234,【家庭教師Reborn!】LISTEN TO THE STEREO【中日字幕】
   https://www.youtube.com/watch?v=OLXakRCP2Jw
   #EXTINF:215,【家庭教師Reborn!】Funny Sunny Day【中日字幕】
   https://www.youtube.com/watch?v=P7253KcNS6Q
   #EXTINF:256,【家庭教師Reborn!】Sakura addiction 【中日字幕】
   https://www.youtube.com/watch?v=_n3gGL4an7Y
   #EXTINF:114,Katekyo Hitman Reborn OST - Flame of Resolution
   https://www.youtube.com/watch?v=1vootQHhLRE
   ```