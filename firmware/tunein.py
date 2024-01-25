import subprocess
import feedparser

# get feed
feed = feedparser.parse("https://video.hackers.town/feeds/videos.xml?sort=-publishedAt")

# iterate over items
for entry in feed.entries:
    print(entry.id)

    # parse id and build media URL
    entry_parts = entry.id.split("/")
    media_url = "https://video.hackers.town/download/videos/{}-360.mp4".format(entry_parts[len(entry_parts)-1])
    print(media_url)


    # TODO: /usr/bin/omxplayer the URL 
    subprocess.run(["/usr/bin/omxplayer", media_url])

