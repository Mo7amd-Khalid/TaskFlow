String generateSurahUri(String url, String surahId)
{
  if(surahId.length == 1)
    {
      return "${url}00$surahId.mp3";
    }
  else if(surahId.length == 2)
    {
      return "${url}0$surahId.mp3";
    }
  else
    {
      return "$url$surahId.mp3";

    }
}