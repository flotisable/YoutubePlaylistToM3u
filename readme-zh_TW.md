# Youtube Playlist To M3u
  將 youtube 播放清單網址轉換成 m3u 檔

## 需求
   - [youtube-dl](https://github.com/ytdl-org/youtube-dl)

     或是其他與 **youtube-dl** 相容的程式，像是 [yt-dlp](https://github.com/yt-dlp/yt-dlp)

## 動機
   我偶爾會用 **mpv** 來播我 youtube 帳號中的收藏的影片，
   不過我必須手動改 m3u 檔案來跟這個播放清單同步。
   最近我也想加一些其他的播放清單，加上有在開始學 [Raku](https://www.raku.org/)，
   所以就想說用它來寫寫程式來做這件事

   這個程式主要的目的也就以下幾點
   - 不須手動而是靠程式更新 m3u 檔
   - 練習使用 **Raku**
     - 尤其是試試它內建的 **grammar** 功能

## 使用
   這個程式可以給下列其中一種輸入
   - youtube 播放清單網址
     - 直接當成參數
   - ```youtube-dl --flat-playlist -j``` 的 json 輸出
     - 用 ```-f``` 選項
     - 或是從 stdin 輸入

   預設輸出是到 stdout，
   可以用 ```-o``` 選項寫到檔案中。
   要注意的是，
   如果影片標題有使用 unicode 而 shell 不支援的話，
   輸出的 **#EXTINF** 後面的標題會有亂碼出現

   如果要使用其他與 **youtube-dl** 相容的程式，可以用 ```--ytdlExec``` 選項設定

## 範例
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