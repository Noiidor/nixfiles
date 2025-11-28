{pkgs, ...}:
pkgs.writeShellScriptBin "yt-music" ''
  ${pkgs.unstable.yt-dlp}/bin/yt-dlp -xcw --embed-thumbnail --embed-metadata --no-mtime --audio-format mp3 -f "bestaudio/best" --audio-quality 0 $1
''
