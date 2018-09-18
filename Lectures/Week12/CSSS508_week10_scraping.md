CSSS 508, Week 10: Social Media and Text Mining
====================================================================================
author: Charles Lanfear
date: November 29th, 2017
transition: linear
width: 1440
height: 900


Topics
====================================================================================

Today we will be covering:

* Important terminology in Social Media and Text Mining
* Collecting Twitter data with `SocialMediaLab` and `streamR`
* Mining text with `tm` 

Collecting Twitter Data
====================================================================================
type: section

Some Terminology
====================================================================================
incremental: true

* Application Program Interface (API): A type of computer interface that exists as the
"native" method of communication between computers, often via http (usable via `httr` package).
   + R packages that interface with websites and databases typically use APIs.
   + APIs make accessing data easy while allowing websites to control access.
* XML and JSON: File formats commonly used for commucation via APIs.
   + Can be parsed with the `XML` and `jsonlite` packages.
* Scrape: The act of extracting data from sources designed to be human readable rather
than machine readable.
   + Technically if one goes through an API, it is not *scraping* data.
   + R can be used to scrape from sources lacking an API but *technical knowledge is required*.
* Rate Limit: A web service's limit to the number of pieces of data you can download in
a given period of time (use `Sys.sleep()` to deal with this).

Twitter
====================================================================================
incremental: true

Twitter has two APIs for obtaining data from tweets and users:

* Twitter REST API
    + Allows reading and writing Twitter data.
    + Can obtain tweets from specific dates and places easily, but doesn't get *everything*
    + Good for obtaining lots of data, data over time, etc.
* Twitter Streaming API:
    + Obtains tweets as they are being posted.
    + Only gives you tweets that were posted while you are watching.
    + Good for following trends, live events, etc.

Set Up
====================================================================================




```r
library(SocialMediaLab); library(tidyverse); library(stringr)
library(twitteR); library(ROAuth); library(grid); library(streamR)

api_key <- "API KEY GOES HERE"
api_secret <- "API SECRET GOES HERE"
access_token <- "ACCESS TOKEN GOES HERE"
access_token_secret <- "ACCESS TOKEN SECRET GOES HERE"

reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL<- "https://api.twitter.com/oauth/access_token"
authURL<- "https://api.twitter.com/oauth/authorize"
```


Social Media Lab
====================================================================================
type: section


Social Media Lab
====================================================================================
incremental: true

Social Media Lab provides a "one-stop shop" for accessing social media data and 
transforming it for network analysis techniques. It works with:

* **Twitter** (Tweets from REST API)
* **Facebook** (Pages and public posts)
* **Instagram** (Public pictures and comments)
* **YouTube** (Videos and comments)

Data from all of these can be collected and analyzed using the same syntax!
[See this introduction to see exactly how much it can do](http://www.academia.edu/19064267/Absolute_Beginners_Guide_to_the_SocialMediaLab_package_in_R).

We will only cover Twitter today, but Facebook and Youtube are similar. Instagram is
more difficult to get API access to, but possible in theory.

SML Work Flow
====================================================================================
incremental: true

Social Media Lab has a simple workflow for collecting data:

1. `Authenticate()` using your credentials
2. Pipe authentication to...
3. `Collect()` where you can specify search parameters.
4. Then either...
   + Use the data as they are for text analysis
   + Use `Create()` to generate network data

It will perform the search and process the data into a usable data frame. This beats
handling `JSON` files yourself!


Twitter's REST API
====================================================================================




```r
tweets_Trump <- Authenticate("twitter", api_key, api_secret,
                             access_token, access_token_secret) %>% 
  Collect(searchTerm="Trump", language="en", verbose=TRUE) %>% 
  as_tibble()

tweets_Trump %>% arrange(retweetCount) %>% select(text)
```


```
# A tibble: 1,500 x 1
                                                                          text
                                                                         <chr>
 1 Come and see Trump News and see what the orange menace has been up to - htt
 2 Having exhausted every other line of attack, New Republic writer goes after
 3 "Please tell Mocha to log out of Trump's account.\n\nCovfefe and Maram = Sy
 4 Trump believes the trip was a home run where ever he went. He's delusional 
 5 The Loneliness of Donald Trump. Great read - take time to savour this brill
 6 "What is covfefe? Donald Trump baffles with late night Twitter post\n\nhttp
 7 @Hirazistable If we get married Trump won't let me make the decision to pul
 8 @Mikel_Jollett Exactly! Trump is a disaster for the country and the world. 
 9 I like thinking big. If youÃ¢â¬â¢re going to be thinking anything, you mi
10 "Trump: \"How much covfefing does a guy gotta do to get some service around
# ... with 1,490 more rows
```

Twitter's REST API 2
====================================================================================




```r
tweets_UW <- Authenticate("twitter", api_key, api_secret,
                                access_token, access_token_secret) %>%
  Collect(geocode="47.6552083,-122.30833,2mi", searchTerm=" ",
          language="en", verbose=TRUE)

tweets_UW %>% arrange(retweetCount) %>% select(text)
```



```
                                                                                                                                                                                                                                                                                         text
1                                                                                                                                                             For the Cafe Racer family: The Day The Circus Left Town, a work of love by Hugh Sutton - https://t.co/qEv1HMORKF #caferacerlove
2                                                                                                                                                                                                                     Air Jordan 3 "5Lab3" Black $275 #5lab3 @ Recess https://t.co/fdo0baUoUy
3                                                                                                                                                                                                           Air Jordan 4 "Thunder" $185 #thunder4 #thunder4s @ Recess https://t.co/HJuXnCGDTP
4                                                                                                                                                                                                           Air Jordan 4 "Thunder" $185 #thunder4s #thunder4 @ Recess https://t.co/nzI4nfEZ2R
5                                                                                                                                                                                                                   I just miss it already Ã­Â Â½Ã­Â¸Â­ @iamblackbear https://t.co/MPS3Cyu1mO
6                                                                                                                                                               Meal 5 and 6. #mejarifusionsushi #seattle #wallingford #sushi #sashimi #foodisfuel #musclefoodÃ¢â¬Â¦ https://t.co/HM2GmavsF1
7                                                                                                                                                                                           Kalmia latifolia ... These are some funky flowers! The anthers popÃ¢â¬Â¦ https://t.co/uudIquuHCF
8                                                                                                                                                                                                                                                   @kibblenbits I saw this on Vox. Terrific!
9                                                                                                                                                                                                                           Regexes were put on this earth to test me, IÃ¢â¬â¢m sure of it.
10                                                                                                                                                                                                                    I want the Sadies to adopt us @ Neptune Theatre https://t.co/8oTnAS9iPe
11                                                                                                                                                                                                                    Udistrict sunset @ Flowers Bar &amp; Restaurant https://t.co/l7HRvKJYlG
12                                                                                                                                                                                                 Justin Townes Earle Sighting: Seattle, Washington/ Neptune Theatre https://t.co/CdPFH5zttS
13                                                                                                                                                                                    Last day of grad school!!! WOOF!!! #nerd #mba #dawgs @ University of Washington https://t.co/Ff8KrvD8Pp
14                                                                                                                                                                                       Today was a good one !!! Renting a house and starting a sticker business !!! https://t.co/4DotCQTmTF
15                                                                                                                                                                                                                @ObeseChess Where else is he gonna put the dang thing you cursed millennial
16                                                                                                                                                                                                                                                  @planetepics @nmyra @u10int - Turkey Owl?
17                                                                                                                                                                                                                                    I'm at @Shell_us in Seattle, WA https://t.co/d1S6RrCQUv
18                                                                                                                                                               #laddiethedalmatian fighting his drugs. So glad he's ok. #drugs #emergencyvetvisit #dalmatianÃ¢â¬Â¦ https://t.co/HXSJHjckiz
19                                                                                                                                                                                                                                     @tbridge Random thrown shit is a theme this week, huh?
20                                                                                                                                                                                                                                                       No thunder for us weather junkies :(
21                                                                                                                                                                                                                                             Anyone here still use @Uber ? If so, how come?
22                                                                                                                                                                                                                                                     Storm watching https://t.co/dincIoSa40
23                                                                                                                                                                                                                              1994 #recess206 #recesskicks @ Recess https://t.co/OEVinNjLGC
24                                                                                                                                                   Interested in a #job in #Seattle, WA? This could be a great fit: https://t.co/G8nRJquZ1Z #runner #marathon #Marketing #Hiring #CareerArc
25                                                                                                                                                             Honduran White Bat Sketch.\n.\n.\n.\n.\n.\n#art #sketch #doodle #peterhon #bat #white #hondurasÃ¢â¬Â¦ https://t.co/XmKIiNVUV1
26                                                                                                                                                                Skeptical squirrel friend is skeptical. #uw #seattle #squirrel #squirrelfriend @ Husky UnionÃ¢â¬Â¦ https://t.co/NO7Iv6LdAm
27                                                                                                                                                             Air Jordan 3 "White Cement" 1994\nPlease ask for more pictures if needed. No returns or refundsÃ¢â¬Â¦ https://t.co/YGPX8N4B2x
28                                                                                                                                                                                                                           Not un pretty. @ Seattle Japanese Garden https://t.co/3pgwnECyrT
29                                                                                                                                                                                                         Air Jordan 7 "Raptor" Comes with replacement box. @ Recess https://t.co/Yo2ANjfJOq
30                                                                                                                                                                         Air Jordan 6 "Black Varsity Red" Left side is a size 12, right side is a size 13. @ Recess https://t.co/fZpak5Rank
31                                                                                                                                                                                         Lebron 9 "Blackout" Comes with original box without lid. #lebron9 @ Recess https://t.co/0UUlhai5WZ
32                                                                                                                                                                                                                                     #uw @ University of Washington https://t.co/fQTq7MkDKE
33                                                                                                                                                               My last stop was the University of Washington, and it proved itself to be a beautiful campus.Ã¢â¬Â¦ https://t.co/WusLKglGND
34                                                                                                                                                                          When the debt is crippling but you found your list headphones. @ University of Washington https://t.co/uf1kuV0lYU
35                                                                                                                                                                                                                             Air Jordan 1 "Metallic" 2001. @ Recess https://t.co/uIpAxmKv4N
36                                                                                                                                                                                                         Air Jordan 10 "Bobcat" $190-$215. Sizes 9, 11, 13 @ Recess https://t.co/fVfzeSWRbv
37                                                                                                                                                                    WARNING: Our new #phra unicorn shirts have magic powers that turn the one into an actualÃ¢â¬Â¦ https://t.co/KgHgVczWZq
38                                                                                                                                                         #TheAve is something for the fall quarter, it's hosted by my DJ....DJ BaccWood Burner this shyt is Ã¢ËâÃ­Â Â½Ã­Â´Â¥Ã­Â Â¼Ã­Â¼Å 
39                                                                                                                                                     Looking JUST like: "Vamushambanegore" Ã­Â Â½Ã­Â¸Â¬. S/O to @sakeyproduction for this beautiful paintingÃ¢â¬Â¦ https://t.co/fpb9we2tK3
40                                                                                                                                                                                                                     @kerrizor Are you thinking hard about what everyone is paying and why?
41                                                                                                                                                                                                                                       New home @ Eastlake, Seattle https://t.co/QbMoGcVbhG
42                                                                                                                                                      Soup weather returns! \nCoconut Red Lentil Dal (#vegan) \nChicken &amp; Apricot Masala @ City Grind atÃ¢â¬Â¦ https://t.co/q0lZsCxtzM
43                                                                                                                                                                                                                                                                  @kerrizor GOT TO LEVEL UP
44                                                                                                                                                                                                                                        @Marshlewd may contain adult concepts\n\nalso dicks
45                                                                                                                                                                                                        @FriskyFelineAD @JackalFilth @ViroSciCollie We are taking four people in a Veloster
46                                                                                                                                                                                                       when everyone else is still in school so you go to campus and follow people to class
47                                                                                                                                                                     Sharing my pretty new top and current obsession with embroidery, plus lots of beautifulÃ¢â¬Â¦ https://t.co/Sfvyc9xb2g
48                                                                                                                                                                                                                                                           Re-brand https://t.co/RKxB33XS14
49                                                                                                                                                                 This is where we were for #memorialday. #herelieslove #seattle #dayoff #noselfiestick @ Lake Union https://t.co/BLn1nh1xKA
50                                                                                                                                           So proud of these guys Ã­Â Â¼Ã­Â¼Å  YC2 gorgeous performance yesterday Ã­Â Â½Ã­Â±Â#SaunaDanceWithSpeedboat @ Lake Union https://t.co/yYTaEOSiKs
51                                                                                                                                         This looks awesome but for a second there I was really hoping that the game itself would be in the hand drawn styleÃ¢â¬Â¦ https://t.co/KLTawfD26k
52                                                                                                                                                                                                               I miss the little animated GIF that used to be here. https://t.co/XISzmTVIWJ
53                                                                                                                                                                                                                            Ã­Â Â½Ã­Â°Â¾ @ University of Washington https://t.co/XMOKN1AyLJ
54                                                                                                                                                            They should have invited us aboard! #superyacht #mayanqueen on #lakeunion #lifeonthewater @ LakeÃ¢â¬Â¦ https://t.co/MgX5Uvk2ZO
55                                                                                                                                            feeling like recent OS X + iOS updates took a shit on all my devices; things def arenÃ¢â¬â¢t working properly like they used to between them.
56                                                                                                                                         @rectangular definitely, but even scientific proofs get things wrong occasionally; i say approach everything with aÃ¢â¬Â¦ https://t.co/cvFRO5Qfgv
57                                                                                                                                                  Last night I drank NyQuil for my cough, then dreamt Kanye introduced me to Zac Efron - Zac and I fell in love. NyQuil addiction imminent.
58                                                                                                                                                                                                         Back to the grind . (@ The Performance Fix in Seattle, WA) https://t.co/LU0MeIpdCR
59                                                                                                                                                                   Oops, too late \n#someonefedme #bffshenanigans #helenandthelmaatitagain #seasonisbroken @Ã¢â¬Â¦ https://t.co/2FdjTSPqkM
60                                                                                                                                                                      There isn't but nothing  like a warm Dick's in your mouth. (at @DicksDriveInS in Seattle, WA) https://t.co/wNe8LJQjak
61                                                                                                                                                             A perfect #MemorialDay off! Beach time with @preshb and a beautiful houseboat BBQ on Lake UnionÃ¢â¬Â¦ https://t.co/wGGok7sOcy
62                                                                                                                                                            Slap that motor on the dock and let's GO! #southlakeunion #memorialdayweekend #Bucky #taylormadeÃ¢â¬Â¦ https://t.co/HkNKc12uU5
63                                                                                                                                                                                                       @lynx_ops Let me know if IÃ¢â¬â¢m one of those lately.\n\nfull of HUM STrESS AGGGH
64                                                                                                                                                              "I've got a harmonica in one hand and a fidget spinner in the other, let's do this Seattle!" -Ã¢â¬Â¦ https://t.co/IDwvnNouNB
65                                                                                                                                                             #TillandsiaTuesday will ring in my trip to @vpconservatory ... tune into the blog (link in bio)Ã¢â¬Â¦ https://t.co/hyJHG8mdHY
66                                                                                                                                                                  Tina Tuesdays!! This is your jam from 6am-11am... Big Wheels keep on turnin', buns keep onÃ¢â¬Â¦ https://t.co/tMTC5e44Fw
67                                                                                                                                                                          @Brushwolf Ã¢â¬ËrestfulÃ¢â¬â¢ doesnÃ¢â¬â¢t matter. Ã¢â¬Ëinterfering with this fucking noiseÃ¢â¬â¢ does.
68                                                                                                                                                                                                               Beautiful night in the patio! @ Little Water Cantina https://t.co/ypsutk3TL7
69                                                                                                                                                                A lovely way to finish off the long weekend #clouds #sunset #seattle #seattleatdusk #sceneryÃ¢â¬Â¦ https://t.co/Y68Za3dB7e
70                                                                                                                                                                        @CabbitAnalytics yep, seeing him tomorrow, definitely gonna talk about this. And the weird peripheral vision thing.
71                                                                                                                                                       @CabbitAnalytics maybe itÃ¢â¬â¢s something in my head? But it sure starts and stops abruptly. And has definite locations. I dunno.
72                                                                                                                                                          Adding in the Black Lodge ambience makes things almost entirely bearable when I have earplugs in. FML.\n\nhttps://t.co/RIJTVumjOK
73                                                                                                                                                       shorty wanna ball w/ the team, money sittin tall yao mingÃ­Â Â¼Ã­Â·Â¨Ã­Â Â¼Ã­Â·Â³ @ University of Washington https://t.co/3Jgq2CJclK
74                                                                                                                                                                                                       @CabbitAnalytics I would imagine theyÃ¢â¬â¢d have Memorial Day off? I dunnoÃ¢â¬Â¦
75                                                                             Memorial Day Monday - Seattle, Lake Union Ã­Â Â½Ã­ÂºÂ£Ã­Â Â¼Ã­Â¿Â» Ã­Â Â¼Ã­Â¿Å  Ã­Â Â½Ã­Â°Å¸ Ã­Â Â½Ã­Â´Â¥ Ã­Â Â½Ã­Â²Æ Ã­Â Â¼Ã­Â½â Ã­Â Â¼Ã­Â½Â· #memorialday #lakeunion @ Lake Union https://t.co/qGMbd4imvL
76                                                                                                                                                                                                                         #15withthekill. @ University of Washington https://t.co/XbqTdNpG9K
77                                                                                                                            @CabbitAnalytics maybe itÃ¢â¬â¢s the tunnel again? I dunno? ThereÃ¢â¬â¢s an entry for a Seattle Hum in the Wikipedia page onÃ¢â¬Â¦ https://t.co/poITAtR5si
78                                                                                                                                                         @CabbitAnalytics i want to kill whoever is responsible for this\n\nitÃ¢â¬â¢s all through the city when itÃ¢â¬â¢s on\n\naaagggh
79                                                                                                                                                                                                                     I'm at Ã¥Â·ÂÃ¥Â®â red Pepper in Seattle, WA https://t.co/1YBTw0C2R4
80                                                                                                                                                                                   Ã¢ÂÂ¤Ã¯Â¸Â these moments with my sweet not-so-little girl.  Wrapping upÃ¢â¬Â¦ https://t.co/jsh96EqMkC
81                                                                                                                                                                     Seattle summers. Ã­Â Â½Ã­Â´â \n(Alternatively called: Hashtagswag) @ University of Washington https://t.co/zcysAY3MrV
82                                                                                                                                                                                                                          Pahty Done @ University District, Seattle https://t.co/nhoWdpaVjV
83                                                                                                                                                                                          flowers of seattle. (on the two block walk from @gruntleme's houseÃ¢â¬Â¦ https://t.co/CbxWCGfsdr
84                                                                                                                                                            If you saw me this weekend I probably raided your ship #pirateslife #emeraldcitypirates #seattleÃ¢â¬Â¦ https://t.co/BRlPxiRTxP
85                                                                                                                                                                                                               #TurnUp @liquidvoyage kamaki2 @ Wallingford, Seattle https://t.co/2ePmHJyt5P
86                                                                                                                                                                                                                                                   @Brushwolf @Pyatmouse mint in box, even!
87                                                                                                                                                    Memorial Day shenanigans on Lake Union Ã¢ÅÅÃ­Â Â¼Ã­Â¿Â¼Ã¢Ëâ¬Ã¯Â¸ÂÃ­Â Â½Ã­Â¸Å½ Great last day in theÃ¢â¬Â¦ https://t.co/UuyMxQacui
88                                                                                                                                                                                  @Brushwolf The longer I stay away from New Orleans, the more of a caricature of a New Orleanian I become.
89                                                                                                                                                                                                                          Just posted a photo @ Streissguth Gardens https://t.co/nkie3Jh3zW
90                                                                                                                                                                                                           Megan ain't ever met a dog she ain't like @ Montlake Cut https://t.co/66U6f7TWXz
91                                                                                                                                                                                                                                Just posted a photo @ I-5 Colonnade https://t.co/X04Hoyt8gK
92                                                                                                                             Trying not to blind everyone with my paleness. Ã­Â Â½Ã­Â¸Å½Ã¢Ëâ¬Ã¯Â¸ÂÃ­Â Â¼Ã­Â¼Ë #selfietime #summer #weekendvibes #seattleÃ¢â¬Â¦ https://t.co/e8p2TIylcF
93                                                                                                                                                                I spent Memorial Day sailing Lake Union with my favorite people. Now it's back to full-swingÃ¢â¬Â¦ https://t.co/8yIlMnLufN
94                                                                                                                           Great way to spend the holiday afternoon with the crew. Ã¢Ëâ¬Ã¯Â¸ÂÃ­Â Â¼Ã­Â½Â¹Ã¢âºÂµÃ¯Â¸Â#memorialday #weekend #weekendvibesÃ¢â¬Â¦ https://t.co/GZtIbcPUCc
95                                                                                                                                                                  Back to civilization!\nOut of the canyon, and feeding my fondness of water with some freshÃ¢â¬Â¦ https://t.co/lb0P08tYhi
96                                                                                                                                                  Atticus, thanks for being the Heihei to my Moana (even though you hated every second of it). Ã­Â Â½Ã­Â²â¢Ã¢â¬Â¦ https://t.co/1UmLT9O4qW
97                                                                                                                                                                                                              Ummmmm ... @JaygeeMacapugay @MelodyButiu @ Lake Union https://t.co/SLCv4YvoMq
98                                                                                                                                                                                                                                   @acetone_kitten In front of the kids? Have you no shame?
99                                                                                                                                                                                                   I have to be honest - I was really quite taken with this turtle. https://t.co/pKJ7VRtwTU
100                                                                                                                                                                                        So happy to have these crazies together again! (He survived a monthÃ¢â¬Â¦ https://t.co/EI8xWvnG18
101                                                                                                                                                                                                                                                                  @BarackObama I miss you.
102                                                                                                                                     Oh hey, the Ã¢Ëâ¬Ã¯Â¸Âis FINALLY OUT in #seattle!!!! #herelieslove #dayoff on a Ã¢âºÂµÃ¯Â¸ÂÃ­Â Â¼Ã­Â¿Â !!!! @ Lake Union https://t.co/lDzRysvRnJ
103                                                                                                                                                                                            Happy #memorialday!!!!! #dayoff at #herelieslove #seattle @ Lake Union https://t.co/tLmMZoIRDB
104                                                                                                                                                             This. Weather. Is. Fantastic.\n#seattle #wa #summer #sunny #weather #hot #fashion #fashionistaÃ¢â¬Â¦ https://t.co/SHgtTO6s2x
105                                                                                                                                                                                                                                    Memorial Day 2017 @ Lake Union https://t.co/fMo6Sg0vj7
106                                                                                                                                                                                  Nature bae Ã­Â Â¼Ã­Â¼Â¿Ã­Â Â¾Ã­Â¶â¹\n#cityfolk #thatpnwlife #mdw @ Ravenna Park https://t.co/b6FdTrtJQd
107                                                                                                                                                               See our latest #Seattle, WA #job and click to apply: Hair Stylist - https://t.co/Y1OhW5smoT #Cosmetology #Hiring #CareerArc
108                                                                                                                                                                                         We are so proud of these 2 and how they played this weekend.  NextÃ¢â¬Â¦ https://t.co/VHOBne55AF
109                                                                                                                                                                                             Black Sun - Isamu Noguchi. Framing the Space Needle. @ Volunteer Park https://t.co/NSn8qVBYfv
110                                                                                                                                                           regrann from appetitediary  -  Post workout #breakfast. Need to refuel! Loving this protein richÃ¢â¬Â¦ https://t.co/yvMJ3OLxrZ
111                                                                                                                                                                                                                      Friends #seattle @ Washington Park Arboretum https://t.co/ZO0GSpERqd
112                                                                                                                                                                                                          Cuban special to help me study chess! @ Toronado Seattle https://t.co/EE0vgXCsCi
113                                                                                                                                                            The 18 Reef teams finishes the season with 2 tournament wins at Winter and Willamette Classics,Ã¢â¬Â¦ https://t.co/MnzFvxvBbQ
114                                                                                                                                                                    @hsofia @TAThorogood ThatÃ¢â¬â¢s madness! Everybody knows software developers run on Mountain Dew X-Treme RedÃ¢âÂ¢
115                                                                                                                                              We're enjoying another delicious slice at our local @PagliacciPizzaÃ­Â Â¼Ã­Â½â¢ on this sunny #Seattle #MemorialDay https://t.co/vWx4iHuhS2
116                                                                                                                                                           Easy, breezy, beautiful - and definitely can't stop sliding down the hill.  #seattle #whatisrainÃ¢â¬Â¦ https://t.co/LIyi5J1eGa
117                                                                                                                                          Lily and baby feet, perfect combo! #footprinttattoo #lilytattoo #flowertattoo #seattletattoo #seattletattooartistÃ¢â¬Â¦ https://t.co/SZD9dxaQJW
118                                                                                                                                                                                              Picnic game strong. #seattle #picnic #yeswayrosÃÂ© @ Volunteer Park https://t.co/sWiXGPja2Q
119                                                                                                                                                          @GiordanMontero and I are helping out buddy https://t.co/TSaOTskNWH for his senior recital today!Ã¢â¬Â¦ https://t.co/5G5qi8h8GJ
120                                                                                                                                                                                                                                    Ã¢âºÂ½Ã¯Â¸Â @ Gas Works Park https://t.co/cNzoI94yXo
121                                                                                                                                                                                                                                    Her name is Queen @ Lake Union https://t.co/HAEFhOYWsQ
122                                                                                                                                                                                                                                       A short blog post about it: https://t.co/3DU2nEJwih
123                                                                                                                                                                                                          When my bird gives me that look. https://t.co/SMJCr5uNm0 https://t.co/7ZplXDZ976
124                                                                                                                                                           Learned something new today. They have boat gas stations. \n\nOf course they do, but I just seenÃ¢â¬Â¦ https://t.co/ZvMynS4fiQ
125                                                                                                                                                                    "Your hair is in my picture of the skyline."\n\n"You're welcome."\n\n#your #youre @ Lake Union https://t.co/GR7pf4tC6N
126                                                                                                                                                                                       On a boat with a direwolf Ã­Â Â½Ã­Â°ÂºÃ­Â Â½Ã­ÂºÂ¤Ã­Â Â¼Ã­Â¼Å  @ Lake Union https://t.co/WcoEHPcc5v
127                                                                                                                                                                   @PaolaNotPaolo Got to love the aggressiveness Ã­Â Â½Ã­Â¸â. Hilarious when you say no to food: https://t.co/IAFUEeLyy5
128                                                                                                                                                                                                                 #memorialdayweekend @brookem0822 @ Gas Works Park https://t.co/9lCjRYAlvb
129                                                                                                                              Chilling + relaxing = #chillaxing Ã­Â Â½Ã­Â¸Å½ #dogswithswag #rufflife #puppypriorities #soseattle Ã­Â Â½Ã­Â°Â¶Ã­Â Â½Ã­Â°Â¾ @Ã¢â¬Â¦ https://t.co/jS0Y9wMk0M
130                                                                                                                                     This is the way I live. Ã­Â Â½Ã­Â°Â¶Ã­Â Â½Ã­Â°Â¾ #chillaxin #soseattle #k5spring #dogswithswag #puppypriorities #PNW @Ã¢â¬Â¦ https://t.co/dnKudqriT8
131                                                                                                              Did you say...TREAT?! Ã­Â Â¾Ã­Â´Â¤Ã­Â Â¼Ã­Â½â #rufflife #dogswithswag #puppypriorities #k5spring #PNW #soseattle Ã­Â Â½Ã­Â°Â¶Ã­Â Â½Ã­Â°Â¾ @Ã¢â¬Â¦ https://t.co/pukBIo36O1
132                                                                                                                                                                #mood: Ã­Â Â½Ã­Â¸Â¬Ã­Â Â½Ã­Â¸Â¬Ã­Â Â½Ã­Â¸Â¬ #rufflife Ã­Â Â½Ã­Â°Â¶Ã­Â Â½Ã­Â°Â¾ @ Montlake, Seattle https://t.co/9rgAOtbEZ4
133                                                                                                                                           Today is B-E-A-UTIFUL!!! Ã­Â Â½Ã­Â°Â¶Ã¢Ëâ¬Ã¯Â¸Â #soseattle #k5spring #puppypriorities #rufflife #dogswithswagÃ¢â¬Â¦ https://t.co/IQwKxPmttv
134                                                                                              Flower baths are my favorite. Ã­Â Â¼Ã­Â¼Â¼Ã­Â Â½Ã­Â»â¬Ã­Â Â¼Ã­Â¿Â¼ #soseattle #puppypriorities #k5spring #PNW #rufflife Ã­Â Â¼Ã­Â¼Â¿Ã­Â Â½Ã­Â°Â¶Ã­Â Â½Ã­Â°Â¾Ã¢â¬Â¦ https://t.co/KZtqdk08CK
135                                                                                                                                                  Just out here being Dora. Ã­Â Â½Ã­Â°Â¶Ã­Â Â½Ã­Â°Â¾ #exploringpuppy #PNW #dogswithswag #k5spring #rufflifeÃ¢â¬Â¦ https://t.co/JqrdJuBAgx
136                                                                                                                                                          Cedar IPA. Pretty damn good - Drinking a Cedrela Odorata by @ElysianBrewing at @elysianbrewing  Ã¢â¬â https://t.co/OBEV7ATn0Z
137                                                                                                                                                                                                                  Just posted a photo @ Dick's Drive In Restaurant https://t.co/SADqPDeDZ1
138                                                                                                                                                                                                 @iamblackbear wicked concert last night Ã­Â Â¾Ã­Â´â¢Ã­Â Â¼Ã­Â¿Â¼ https://t.co/2pZlRgRuwW
139                                                                                                                                                                Before and After. 9:30am through the Montlake Cut 11:30am back again. If you don't like theÃ¢â¬Â¦ https://t.co/46tYAWXXP2
140                                                                                                                                                                        Drinking a Chroma-Key Oak Aged Imperial IPA by @ElysianBrewing at @elysianbrewing Ã¢â¬â https://t.co/iBwy9mwSUW
141                                                                                                                                                                                                My kind of plan #kayaking #lakeunion #downtownseattle @ Lake Union https://t.co/ObuLiXFUmJ
142                                                                                                                                                                                        No - Drinking a Savant IPA by @ElysianBrewing at @elysianbrewing  Ã¢â¬â https://t.co/82wkJJtdpt
143                                                                                                                                                                                                                             The send off @ Husky Softball Stadium https://t.co/LfHmaqJGAp
144                                                                                                                                                                                             Drinking a Dayglow IPA by @ElysianBrewing at @elysianbrewing Ã¢â¬â https://t.co/Zzz5hEfnfB
145                                                                                                                                                                                       Drinking a Snailbones by @ElysianBrewing at @elysianbrewing Ã¢â¬â https://t.co/HvNQP4oUdM #photo
146                                                                                                                                                                                                  Ã¢Å¾âLet's for Joshua @bboyduskvoid @ University of Washington https://t.co/Eclc0VxtSq
147                                                                                                                                                                                                        #mood: Ã­Â Â½Ã­Â¸Â¬Ã­Â Â½Ã­Â¸Â¬Ã­Â Â½Ã­Â¸Â¬ @ Montlake Cut https://t.co/cKqB7wtqbc
148                                                                                                                                                                                                                                            duck fam came to visit https://t.co/e7DAN8dwcN
149                                                                                                                                                                                         Grasshoppa! Ã­Â Â½Ã­Â°Â¶Ã­Â Â¼Ã­Â¼Â¿ #puppypriorities @ University Bridge https://t.co/jFvNiNamN5
150                                                                                                                                                                                        We out here. Ã­Â Â½Ã­Â²Â¦Ã­Â Â½Ã­Â°Â¶Ã­Â Â¼Ã­Â¼Â¿ #rufflife @ Montlake Cut https://t.co/5P4TDRE0qq
151                                                                                                                                                           I'll venmo $1 to the first person who guesses my fav thing in this photo  Ã­Â Â½Ã­Â²Â¸ @ Gas Works Park https://t.co/eioMWeZiIq
152                                                                                                                                                                                                                                      Just relax. @ The Quad at UW https://t.co/gfiBW86Qr4
153                                                                                                                                                           Seattle trivia for you: Former mayor Paul Schell's last name at birth was Schlachtenhaufen, which means "battleheap" in German.
154                                                                                                                                                                                                        @cananito Vim 8 has native packages https://t.co/UTqHwInGED otherwise use vim-plug
155                                                                                                                                                                                               Drinking a Lioness by @SkookumBrewery @ Bottleworks Ã¢â¬â https://t.co/JvB7IZ24Kc #photo
156                                                                                                                                                                                                        @calumhc I saw your "git pull" t shirt while walking around.  Where can I buy one?
157                                                                                                                                                               Getting in a little #water time today. #portagebay #kayak #lakeunion #aguaverde @ Agua VerdeÃ¢â¬Â¦ https://t.co/6vzvAa24mf
158                                                                                                                                                    Finished up this nature 3/4 sleeve today! #tattoosleeve #naturetattoo #owltattoo #foxtattoo #treetattooÃ¢â¬Â¦ https://t.co/FQmT40vSTT
159                                                                                                                                                                                                                              Just posted a photo @ Gas Works Park https://t.co/1vNcfAwfGo
160                                                                                                                                                         Memorial Day Murph. #interbae #murph #murphchallenge #ftwga Ã­Â Â¼Ã­Â·ÂºÃ­Â Â¼Ã­Â·Â¸ @ Northwest CrossFit https://t.co/xnypwdCdBd
161                                                                                                                                                                 Definitely not plotting how to distract those kids in order to acquire their super awesomeÃ¢â¬Â¦ https://t.co/J7Y4AZgCeT
162                                                                                                                                                                 It's #perfect out today! Start your afternoon right, a #refreshing punches waiting for youÃ¢â¬Â¦ https://t.co/8fKYJgN0lw
163                                                                                                                          I am ready to graduate! Ã­Â Â½Ã­Â±Â©Ã­Â Â¼Ã­Â¿Â¼Ã¢â¬ÂÃ­Â Â¼Ã­Â¾âÃ­Â Â½Ã­Â±Â©Ã­Â Â¼Ã­Â¿Â¼Ã¢â¬ÂÃ­Â Â½Ã­Â´Â¬Ã­Â Â½Ã­Â²â°Ã­Â Â½Ã­Â²Å  https://t.co/MitSgyom1Z
164                                                                                                                                                           One of the classics from the early 2000s retros. The Legend Blue 4s were released again in 2015.Ã¢â¬Â¦ https://t.co/ohaE6LILvG
165                                                                                                                                                                                                               Mattis says what keeps him awake at night - YouTube https://t.co/tbPfMozBy3
166                                                                                                                                                                                                                                                         LOLIRLCHP https://t.co/3KKKjAzYcs
167                                                                                                                                                                                         It'll burn off... Ã¢ËÂÃ­Â Â¼Ã­Â¿Â¼Ã­Â Â½Ã­Â¸â° #soseattle @ Lake Union https://t.co/yRS62SurKm
168                                                                                                                                                                             Her: Great picture! Where was this taken?\nMe: Starbucks Restroom\nHer: Ã­Â Â½Ã­Â¸â https://t.co/P7XxMI8Tr9
169                                                                                                                                                                       @arthurwyatt Ã¢â¬Åhey comic shops wanna dress up as pseudo-nazis, weÃ¢â¬â¢ll provide the shirts for freeÃ¢â¬Â
170                                                                                                                                                                       @arthurwyatt status quo must always be returned to\n\nthe PropertyÃ¢âÂ¢ must be maintained for the maximal profit
171                                                                                                                                           or maybe iÃ¢â¬â¢ll draw a symbol of the Proletariat punchinÃ¢â¬â¢ a symbol of the Military-Industrial Complex, it IS Memorial Day after all
172                                                                                                                                                                                               anyway Imma gonna go draw Columbia in superhero drag punchinÃ¢â¬â¢ Trump or something w/e
173                                                                                                                                                                                                                                                                                 ,,comics)
174                                                                                                                               (TECHNICALLY itÃ¢â¬â¢s not over but it has been revealed that Nazi Cap is actually Mirror Universe Cap shaving his goatee &amp; Real Cap on ice &amp; ugh
175                                                                                                                           @arthurwyatt Ã¢â¬Åpeople will finally stop writing so many thinkpieces about it now that we know this isnÃ¢â¬â¢t the Real CaÃ¢â¬Â¦ https://t.co/aCDBrilFLE
176                                                                                                                   @DoodlestheGreat ItÃ¢â¬â¢s actually the Evil Mirror Universe Cap! HeÃ¢â¬â¢s been shaving his goatee all along! And Real CapÃ¢â¬â¢sÃ¢â¬Â¦ https://t.co/YMo1r2VRWm
177                                                                                                                                        @arthurwyatt I saw something this morning about now it turns out Nazi Cap is Evil Parallel World Cap replacing RealÃ¢â¬Â¦ https://t.co/vUTkOdc3bp
178                                                                                                                                                                             TheyÃ¢â¬â¢re all seventy years old, fucking let them go out to pasture already and make way for new stories
179                                                                                                                                                                      So apparently the Nazi Captain America story is finally over and uggghhh why do I even know about this cape bullshit
180                                                                                                                                                                                                                                   Make today a #MargheritaMonday! https://t.co/M59FMcGBB7
181                                                                                                                                                              18 Reef wins its 1st match of the day and continues its run at the ECC Championship under theÃ¢â¬Â¦ https://t.co/6qQesdWH2o
182                                                                                                                                                               Latte after a yoga class ... this long weekend goes by so fast .  #coffee #cafe #instacoffeeÃ¢â¬Â¦ https://t.co/g44RX7vlJg
183                                                                                                                                                    YC2 performs today 1-3pm Ã­Â Â¼Ã­Â¼Å  Portage Bay Reach. View from Sakuma Viewpoint or a vessel of yourÃ¢â¬Â¦ https://t.co/6p7qXYU6nG
184                                                                                                                                                                                     #LegendaryHeros #SifuBruceLee #BrandonLee @ Bruce and Brandon Lee's Gravesite https://t.co/M1fTjiQ5um
185                                                                                                                                                                                                         Best night of my fucking life I love u bear @iamblackbear https://t.co/BQs2RE2FA5
186                                                                                                                                                Framing another shot for our #photoshoot with Holly wildideal Ã­Â Â½Ã­Â³Â¸Ã­Â Â½Ã­Â±Å @ Washington Park Arboretum https://t.co/ySQcflb86P
187                                                                                                                                          Follow @HaleyRhoadesBks &amp; tweet this message for a chance to win 1 of 2 AmazonEchos #giveaway #TheProposal https://t.co/3dVMzDiI9e #giveaway
188                                                                                                                                              Sale on a Over The Sink Strainer on Amazon https://t.co/w7cqQLCxbt Enter #AmazonGiveaway for discount code https://t.co/ikK7kJ8RZW #giveaway
189                                                                                                                                                                                                                                                                @NeoGeen ex-yerf represent
190                                                                                                                                                                             @KSeattleWeather Heading for Phoenix tomorrow. I'll take it! Ã­Â Â¼Ã­Â¼Â¥Ã­Â Â¼Ã­Â¼Â«Ã­Â Â¼Ã­Â¼Â¾Ã­Â Â¼Ã­Â¼Å 
191                                                                                                                                                                                                 Alright, alright, alright. Ã­Â Â½Ã­Â¸Â #mondayvibes @ Lake Union https://t.co/IssuanBxGo
192                                                                                                                                                                                                          Happy Eritrean Independence day!!!! #26 @ Volunteer Park https://t.co/ZItBjmAYme
193                                                                                                                                                                         Created a workflow for searching CocoaPods and copying the pod 'Query' to your clipboard: https://t.co/Mbi1o0EyWo
194                                                                                                                                                                                                                                                 Skate like a girl https://t.co/Ddf4XrNS1k
195                                                                                                                                                              As we head into the final day of Emerald City Classic, KJ would like to extend a huuuge THANKÃ¢â¬Â¦ https://t.co/ubNb0ckXcZ
196                                                                                                                                                                    #PlantSelfie??? Reflections at the @vpconservatory in Seattle. Thanks all for the GREATÃ¢â¬Â¦ https://t.co/SNW3vqH4qu
197                                                                                                                                                                                            Day 3 of the ECC at UW!  Jayde's team is playing for the silverÃ¢â¬Â¦ https://t.co/Q1XKIBcKNq
198                                                                                                                                                                                                             @agisilaosts Thanks for the article. Definitely resonates with my experiences
199                                                                                                                                                                                                 @PaolaNotPaolo I hear this playing out with Knuck if you buck by Crime Mob Ã­Â Â½Ã­Â¸â.
200                                                                                                                                                                                                  Not a bad way to spend a Sunday! 92' yacht. $6.5 million.Ã¢â¬Â¦ https://t.co/mEq4ZZxV6n
201                                                                                                                                                          We're #hiring! Read about our latest #job opening here: Urgently Seeking an Emergency Room RN - https://t.co/RyF7ObJIWM #Nursing
202                                                                                                                                                                                                                   Up to 64% Off Hair Services at MargiDavid Salon https://t.co/LLIzROV6ve
203                                                                                                                                                Tonight was great. I barely took my phone out for pics and it was so nice to watch with my own eyes. ThanksÃ¢â¬Â¦ https://t.co/hOnzxXLDVp
204                                                                                                                                                                                                                                         blackbear .. Ã­Â Â¼Ã­Â¼Â¹ https://t.co/33Ewb4WCnM
205                                                                                                                                                                                                  In my defense, something was very wrong with it and I had to cut it open with an X-Acto.
206                                                                                                                                               I love to watch movies like Logan that make you feel invincible but then I remember that I got a blister trying to open a Dr. Pepper today.
207                                                                                                                                                                                                                                  Ã­Â Â½Ã­Â¸Â @ Montlake, Seattle https://t.co/FTBEKHvS8N
208                                                                                                                                                                                                                                                             This place  is packed. #Dicks
209                                                                                                                                                                                        Beyond thankful for this moment I've been dreaming of since I was aÃ¢â¬Â¦ https://t.co/7feWsNUbh0
210                                                                                                                                                                                      This was the only song I needed to hear tonight #blackbear @ Neptune Theatre https://t.co/fwZRVYAJYZ
211                                                                                                                                               It's been real husky softball stadium, see you next year. OKC, here come my Dawgs! @UWSoftball #LeaveNoDoubtÃ¢â¬Â¦ https://t.co/A5FnE0ZY0o
212                                                                                                                                                                                                   Last Spanish Coffee Sunday. Make it count. @ Sea Monster Lounge https://t.co/ZboYaBBXTe
213                                                                                                          Mattis was also asked: Ã¢â¬ÅWhat keeps you awake at night?Ã¢â¬Â\n\nÃ¢â¬ÅNothing,Ã¢â¬Â he said. Ã¢â¬ÅI keep other people awake at night.Ã¢â¬Â https://t.co/GxDNu3ML5b
214                                                                                                                                                                                                                           Cat is long, curious @ Ravenna, Seattle https://t.co/UBzOTAd9QF
215                                                                                                                                               Ã¢â¬Â¢ congrats to @uwsoftball for making it to the Women's College World Series Ã¢â¬Â¢ so great going andÃ¢â¬Â¦ https://t.co/5DdXqHMiMD
216                                                                                                                                                                                          For someone that eats at red robin pretty often, I have no right to be claiming IÃ¢â¬â¢m broke
217                                                                                        Way to go lady DAWGS!!!! #godawgsÃ­Â Â½Ã­Â°Â¾ #espn #okcbound #uw Ã­Â Â½Ã­Â²ÅÃ­Â Â½Ã­Â²âºÃ­Â Â½Ã­Â°Â¾Ã¢ÅÂ¨Ã¢ÅÂ¨Ã¢ÅÂ¨Ã¢ÅÂ¨Ã¢ÅÂ¨Ã­Â Â¼Ã­Â¼Ë @ Husky Softball Stadium https://t.co/kM0IftTNiP
218                                                                                                                                                                                                 happy birthday @mattsacks do you like the matching boys i got you https://t.co/35DkyDCRu1
219                                                                                                                                                                147.365 :: Couldn't have asked for better views along the @cascadebicycle Emerald City RideÃ¢â¬Â¦ https://t.co/GBJ3KblOlH
220                                                                                                                                                                                                      Three-day weekends mean 6pm iced coffees!!! @ Volunteer Park https://t.co/NECBKy0HAw
221                                                                                                                                                             @LuDux Fractals werenÃ¢â¬â¢t really EVERYWHERE!!!! until around the time I started college, I think. It all blurs together.
222                                                                                                                                                                                                  The water Ã­Â Â½Ã­Â²Â¦ tower at Volunteer Park. @ Volunteer Park https://t.co/hANlEMpXfG
223                                                                                                                                                               wing gates might have thermals over them, maybe thereÃ¢â¬â¢s hovering versions as well, also pretty skyboxes to run into.
224                                                                                                                                                                                                                                In the treeeeees! @ Volunteer Park https://t.co/tYMADsguC3
225                                                                                                                                            it would be about moving very fast, very low to the ground; IÃ¢â¬â¢d see what else emerged from making models and playing with interactions.
226                                                                                                                                                                                                             would you like to see my polybius self-insert fan art https://t.co/Gg183RKMbB
227                                                                                                                                                                                                                Off to OKC! #SuperRegionals #UWHuskies @UWSoftball https://t.co/p2Hwe5sUNn
228                                                                                                                                                                                                               Supporting local! @ Molly Moon's University Village https://t.co/7mZddl8mQI
229                                                                                                                                                                                                                                            Lady Dawgs need an insurance run or more here.
230                                                                                                                                 @JulieTRRoo sometimes when I play it the back of my head starts tingling and I kinda stop thinking, itÃ¢â¬â¢s kinda awesÃ¢â¬Â¦ https://t.co/w9vlIhikvY
231                                                                                                                                                             --&gt; Seattle. This place is Iconic. Yea. (at @DicksDriveInS in Seattle, WA) https://t.co/8Mou7X9H7c https://t.co/ECie9hH9JJ
232                                                                                                                                           @JulieTRRoo You think the stills are hard on the eyes, try watching the videos. n.n\n\nI have Thumper but I couldnÃ¢â¬â¢t really get into it.
233                                                                                                                                                             Hike &amp; Bike weekend. 22 mile ride today. I never grew up, I'm still riding a BMX. lol. I'mÃ¢â¬Â¦ https://t.co/SdQMSNMCLK
234                                                                                                                                                                                                                                   @brennx0r The Beach House Cafe: https://t.co/g58AvN2Bfb
235                                                                                                                                                           18 Reef goes undefeated for the 2nd day at the Emerald City Classic at 6-0! Gold bracket quarterÃ¢â¬Â¦ https://t.co/NfQAuOx5RB
236                                                                                                                                                         Prepping alder-smoked morel mushroom, nigella seed &amp; cashew cheese mung bean crepes w/a nettleÃ¢â¬Â¦ https://t.co/Qs7U4cM4PY
237                                                                                                                                                                                             the dear mr fantasy off welcome to the canteen is potentially the greatest song ever recorded
238                                                                                                                                                              Paying respect to a exceptional and inspiring martial artist #brucelee #gravesite #jeetkunedoÃ¢â¬Â¦ https://t.co/BsSAKWGdiK
239                                                                                                                                          Polybius DLC that adds one single achievement:\n\nThe Long Hard Way To Basingstoke.\n\nComplete level 50 in YOLO mode.\n\n(basically impossible)
240                                                                                                                                                                                                                                  My kinda people @ Gas Works Park https://t.co/WcYkhjCvI5
241                                                                                                                                                                                                                                                        summer boy https://t.co/HcQwrcPnaz
242                                                                                     Beautiful day for Husky Stadium!!  #win #beatutah #espn #supers #softballlife Ã­Â Â½Ã­Â²ÅÃ­Â Â½Ã­Â²âºÃ¢ÅÂ¨Ã¢ÅÂ¨Ã¢ÅÂ¨Ã¢ÅÂ¨Ã­Â Â½Ã­Â°Â¾Ã¢Ëâ¬Ã¯Â¸ÂÃ¢Å¡Â¾Ã¯Â¸Â @Ã¢â¬Â¦ https://t.co/OmFx59hQr4
243  Look they do get along! #sisterlife #sunday #softballlife #supers #espn Ã­Â Â¼Ã­Â¼Å¸Ã­Â Â¼Ã­Â¼ËÃ­Â Â½Ã­Â²ÅÃ­Â Â½Ã­Â²âºÃ¢Å¡Â¾Ã¯Â¸ÂÃ­Â Â½Ã­Â±Â±Ã­Â Â¼Ã­Â¿Â¼Ã¢â¬ÂÃ¢â¢â¬Ã¯Â¸ÂÃ­Â Â½Ã­Â±Â±Ã­Â Â¼Ã­Â¿Â¼Ã¢â¬ÂÃ¢â¢â¬Ã¯Â¸ÂÃ­Â Â½Ã­Â±Â§Ã­Â Â¼Ã­Â¿Â¼ @Ã¢â¬Â¦ https://t.co/kmZ2HY8qRU
244                                                                                                                                                                                                                                     This whole cultural appropriation/authenticity thing.
245                                                                                                                                                                                    Founder of Jeet Kune Do #seattle #brucelee @ Bruce and Brandon Lee's Gravesite https://t.co/NIJ4R4qqYM
246                                                                                                                                                                                            UW flower garden adjacent to Rainier Vista. @ University of Washington https://t.co/ZM5q7OIS6A
247                                                                                                                                                Hey entrepreneurs: ice cream is really not that complicated. Open a store on Capitol Hill and make stacks o' cash. https://t.co/H0KafqwPjc
248                                                                                                                                                                                        Heaven. #nofilter #summer #seattle #iphone7plus @ University of Washington https://t.co/nOBfsRic9Q
249                                                                                                                                                       6.9.17 Gas Works Park 5pm-10pm Ã¢ÂÂ¤\n\nnever been to a silent disco before. come with me! oh and iÃ¢â¬Â¦ https://t.co/MvFR65ZRtg
250                                                                                                                                                                                         "Be strong and courageous. Do not fear or be in dread of them, forÃ¢â¬Â¦ https://t.co/p1j9oNLlwU
251                                                                                                                                                                                                      Summer in Seattle Ã¢Ëâ¬Ã¯Â¸ÂÃ­Â Â½Ã­Â´Â @ Gas Works Park https://t.co/emXHZ8Ni0I
252                                                                                                                                                                                                                                         Philosophy in four words. https://t.co/X6cS5XnQCD
253                                                                                                                                                                                                       MDW in the PNW is AOK Ã­Â Â½Ã­Â±ÅÃ­Â Â¼Ã­Â¿Â¼ @ Lake Union https://t.co/ic7efJIPHG
254                                                                                                                                                                                                                                                        @PurpleRow Where's the link to buy
255                                                                                                                                  @marsh_dragon I am pretty sure Slack Wyrm would be lying around touching his oversized genitals if he wasnÃ¢â¬â¢t stuckÃ¢â¬Â¦ https://t.co/htoyKaUj9k
256                                                                                                                                                                                                        @marsh_dragon Does that shirt say Ã¢â¬Åcult of slackwyrmÃ¢â¬Â\n\nbecause, yes.
257                                                                                                                                               #turftalk Ã¢ÅÅÃ­Â Â¼Ã­Â¿Â¼Ã­Â Â½Ã­Â¸Å½ #sundayrunday Ã­Â Â¼Ã­Â¿ÆÃ­Â Â¼Ã­Â¿Â½Ã¢â¬ÂÃ¢â¢â¬Ã¯Â¸Â @ Montlake Cut https://t.co/sGSVi4AUUB
258                                                                                                                                                                    Great day in #Seattle on the #seaplane. @kenmoreair does an amazing job showing off theÃ¢â¬Â¦ https://t.co/GBCcueEMlj
259                                                                                                                                                                                I adore this packaging Ã­Â Â½Ã­Â¸Â also SUCH a good chocolate bar! @theochocolate https://t.co/8ABdgqdnOO
260                                                                                                                                                                                                                    Just posted a photo @ University of Washington https://t.co/4pHhfKwxLu
261                                                                                                                                                          Tools of the trade \n\n#gardening #gardenshed #uw #universityofwashington #medicinalherbgardens @Ã¢â¬Â¦ https://t.co/ZNlDhOLRQ8
262                                                                                                                                                                                     Montlake bridge be all like Ã­Â Â½Ã­Â¹Å with this weather too @ Montlake Cut https://t.co/OLOmCSBflk
263                                                                                                                                                                                                                   I'm at UW: Medicinal Herb Garden in Seattle, WA https://t.co/ONnIuUaMhw
264                                                                                                                                                                  Discovered a very nice neighborhood art store in seattle .. nice huge sale going on. #artÃ¢â¬Â¦ https://t.co/12EYgODjHC
265                                                                                                                                                              SIXTEEN. Just like my agent level in Ingress. Ã­Â Â½Ã­Â¸Â\n\n#YourName \n#Ã¥ÂâºÃ£ÂÂ®Ã¥ÂÂÃ£ÂÂ¯ https://t.co/IqIjHoEBsW
266                                                                                                                                                                                                                     I'm at UW: Rainier Vista - @uw in Seattle, WA https://t.co/1CVftXEAJG
267                                                                                                                                                                                                                         I'm at University District in Seattle, WA https://t.co/waFzJNoRfD
268                                                                                                                                                                                                                                             What fun games are you playing on your phone?
269                                                                                                                                                                                                                            Happy Sunday Ã­Â Â¼Ã­Â½Â¸Ã¢Ëâ¬Ã¯Â¸Â https://t.co/th0ioFEx5g
270                                                             Ran 10.01 miles with NikeÃ¢ÂÂ + Run Club Ã¢Åâ¦ #JustDoIt #sundayrunday Ã­Â Â¼Ã­Â¼Å¾Ã­Â Â¼Ã­Â¿ÆÃ­Â Â¼Ã­Â¿Â½Ã¢â¬ÂÃ¢â¢â¬Ã¯Â¸Â #thesweatlife #RUNSEA Ã­Â Â¾Ã­Â´ËÃ­Â Â¼Ã­Â¿Â¼Ã­Â Â½Ã­Â¸ÅÃ¢â¬Â¦ https://t.co/M9OHysqPC8
271                                                                                                                                                                                                                        I'm at RoRo BBQ &amp; Grill in Seattle, WA https://t.co/YbAMOqC562
272                                                                                                                                                                                                                                   I'm at Bala Yoga in Seattle, WA https://t.co/og10ZQWqij
273                                                                                                                                                 Great day for an oyster brunch on Lake Union (@ Westward - @huxleywallace in Seattle, WA) https://t.co/jc0BowSeQS https://t.co/K83vpjat46
274                                                                                                                                               In the 80s to get online you had to strangle an RS-232 cable for 2-3 hours straight while making Qbert fart-noises. https://t.co/YKkXkxA1OV
275                                                                                                                                             Beautiful views from the I-5 express lane during the Emerald City Bike Ride. Ã­Â Â½Ã­ÂºÂ´Ã¢â¬ÂÃ¢â¢â¬Ã¯Â¸ÂÃ¢â¬Â¦ https://t.co/ZMTmDLKOj7
276                                                                                                                                                           Another drawing from today's session .. feeling a little rust ;)\n#drawingmodel #charcoaldrawingÃ¢â¬Â¦ https://t.co/ikfbmd0oNT
277                                                                                                                                           Loving #summertime #pedicures. @OPI_PRODUCTS #endlesspurplepursuit #purple #toes #flipflops #reef #forgottoshaveÃ¢â¬Â¦ https://t.co/RrYwkiAqp0
278                                                                                                                                            We out here. Ã¢ÅÅÃ­Â Â¼Ã­Â¿Â¼Ã­Â Â½Ã­Â¸Å½ #sundayrunday Ã­Â Â¼Ã­Â¿ÆÃ­Â Â¼Ã­Â¿Â½Ã¢â¬ÂÃ¢â¢â¬Ã¯Â¸Â @ Montlake Cut https://t.co/j4d6gTtqvQ
279                                                                                                                                                                                                                           A lil old with the new @ Gas Works Park https://t.co/J4trybqlnb
280                                                                                                                                                                       See our latest #Seattle, WA #job and click to apply: Web Developer - https://t.co/tyWBP62H9U #IT #Hiring #CareerArc
281                                                                                                                                                                    Today's drawing of Tami :) big chunk of charcoal #emiliyalane #drawing #charcoaldrawingÃ¢â¬Â¦ https://t.co/gQ29ZfrBXf
282                                                                                                                                                                                                                                                                   @Pyrao terrible news :(
283                                                                                                                                                        Want to work at Road Runner Sports? We're #hiring in #Seattle, WA! Click for details: https://t.co/gstsOGSRhp #CustServ #Job #Jobs
284                                                                                                                                             Practice implies repetition. 5th day of #yoga and my body is feeling soy much better. Ã­Â Â½Ã­Â¹ÂÃ­Â Â¼Ã­Â¿Â¾Ã¢â¬Â¦ https://t.co/TVSYyiwDVy
285                                                                                                                                                                                         Perfect on a hot #summer day! Love this #shandy ! The lemon flavorÃ¢â¬Â¦ https://t.co/bcIvZsqyJq
286                                                                                                                                                                        if only we had highways for bikes all the time! #emeraldride #seabikes @ Ship Canal Bridge https://t.co/4gqME0pLca
287                                                                                                                                                                                          #Tedx #yesand (@ Kane Hall - @uw in Seattle, WA) https://t.co/3OOADaaoTp https://t.co/LNO5LoWeU8
288                                                                                                                                                            We're #hiring! Find out about our latest opportunity here: Crew - https://t.co/N6ZQbKlXiW #Hospitality #Seattle, WA #Job #Jobs
289                                                                                                                                                                                                                   Very excited for today's TEDx conference at UW! https://t.co/JLOlalfoNj
290                                                                                                                                                               Loving this Sunday Morning with these powerful ladies. #Blessed #PowerTribe #tedxyesand @ Kane Hall https://t.co/f98DWRSu06
291                                                                                                                                                                                                                                          @damonagnos Dialogue must be in tweet storm form
292                                                                                                                                                                                                   Going kayaking! #summer #seattle @ Waterfront Activities Center https://t.co/e6KKJbFp9T
293                                                                                                                                                                       Waiting for canoes. #blackandwhite #blackandwhitephotography @ Waterfront Activities Center https://t.co/uMzCgNiFiN
294                                                                                                                                                           regrann from appetitediary  -  Their marinated #kale salad was on point!  - #regrann @ HeartBeetÃ¢â¬Â¦ https://t.co/TtvOgzv5KT
295                                                                                                                                                                                         "The key to immortality is first living a life worth remembering."Ã¢â¬Â¦ https://t.co/0Rcm8a45OZ
296                                                                                                                                                    Really funny to hear my daughter playing with her toys and complain that there is no parking for their car Ã­Â Â½Ã­Âºâ Ã­Â Â½Ã­Â¸â
297                                                                                                                                                        First official 18K #bikeride on a Sunday. #emeraldbikeride2017 #I5experienceride\n.\n.\n.\n#fitnessÃ¢â¬Â¦ https://t.co/3A6zWOBGMG
298                                                                                                                                                                                                                            I'm at Portage Bay Cafe in Seattle, WA https://t.co/o8MXlqXIvq
299                                                                                                                                                               Happy and Safe Memorial Day Weekend to all!  Unending gratitude to our military and civilianÃ¢â¬Â¦ https://t.co/1oBkR19NVX
300                                                                                                                                                                  Interested in a #job in #Seattle, WA? This could be a great fit: https://t.co/iGCjvuWoM1 #Cosmetology #Hiring #CareerArc
301                                                                                                                                                        @whitstrack @imaniapostol @darhianm &amp; Laura Anuakpado of @uwtrack are all going to the 'ship inÃ¢â¬Â¦ https://t.co/vyhTLJAIp4
302                                                                                                                                                                                          Taking some time for peace and quiet before the whistles start sounding. https://t.co/LRJr9NvzGK
303                                                                                                                                                                                                                  Capitol Hill gunfire? Two incidentsÃÂ overnight https://t.co/f5SMvyU6Mr
304                                                                                                                                                                                                              The Great Gig in the Sky. @ University of Washington https://t.co/MlI0I8pe8W
305                                                                                                                                                           Even three entrees are not enough when dining at @SerafinaOsteria. Squid ink pasta with octopus,Ã¢â¬Â¦ https://t.co/J03BKpi8tD
306                                                                                                                                                 Waited almost 8 hours for a break, and thems is the spoils kiddos...Ã­Â Â½Ã­Â¸â¢ I'd be more disappointedÃ¢â¬Â¦ https://t.co/T6ujCeK2eL
307                                                                                                                                                             Dragged @ziuziuziu up from PDX to Seattle to drink a lot of soju and talk #GreatestGen Raz &amp; Plaveem conspiracy theories.
308                                                                                                                                            It's the final game day in husky stadium. It's do or die time .. I'll take my odds with my Dawgs! #LeaveNoDoubtÃ¢â¬Â¦ https://t.co/4wrsnjDHnw
309                                                                                                                                                                   My musical friends Ã­Â Â¼Ã­Â¾ÂµÃ­Â Â¼Ã­Â¾Â¶ #musicians #engineers #rockstars @ Blue Moon Tavern https://t.co/HqHQj1e4OK
310                                                                                                                                                                                       #Spacesuit &amp; #Scoot #mto #scootlife #scooterrally @ Eastlake Zoo Tavern https://t.co/Hfwi9AHs3P
311                                                                                                                                                             This was my first time dropping in to @streetbeanco in the UD today.  Lovely little space withÃ¢â¬Â¦ https://t.co/VZ3V8DCz6t
312                                                                                                                                              Get the W tomorrow UW and pack your bags for OKC!! #backthePAC #uwsoftball #gopurple #begold #wcwsbound #onemoregame https://t.co/XueEuoqobq
313                                                                                                                                                                                                  Not our first rodeo Ã¢ÅÂ¨ @ Zeta Psi - University of Washington https://t.co/hbLnShe8Hi
314                                                                                                                                                           Finally back home with my girls!! My broadcasting has finally come to an end this year!! What anÃ¢â¬Â¦ https://t.co/S4UpSBBjmn
315                                                                                                                                                               Great evening of canoeing. Made it back JUST at the cut off at 8 pm. @ Waterfront Activities Center https://t.co/GpSydMdGei
316                                                                                                                                                              18 Reef goes undefeated on Day 1 of the Emerald City Classic without dropping a set! Let's doÃ¢â¬Â¦ https://t.co/Ws0ZtjJtNv
317                                                                                                                                                                                                                                                @iamblackbear @2fourhrs see y'all tomorrow
318                                                                                                                                                                                                smile if you didn't eat a live goldfish yesterday @ Chi PsiÃ¢â¬Â¦ https://t.co/aqQoRHghhD
319                                                                                                                                                                                                                      Goodnight Seattle @ University of Washington https://t.co/86OdivCUWH
320                                                                                                                                                                                                 I'm at Frank's Oyster House &amp; Champagne Parlor in Seattle, WA https://t.co/iq9AF6ohm9
321                                                                                                                                                                Hoping for a Monday discharge. Lucky me I get to bring these lovies home. \n#livywontlikeitÃ¢â¬Â¦ https://t.co/zki6Ml2WT9
322                                                                                                                                               Poke bowls with a view is the perfect way to end a beautiful day! (@ Gas Works Park - @seattleparks in Seattle, WA) https://t.co/bkvI0NVnZe
323                                                                                                                                                              18 Reef goes undefeated on Day 1 of the Emerald City Classic without dropping a set! Let's doÃ¢â¬Â¦ https://t.co/8iiWyTkNMC
324                                                                                                                                                                                       no punches were thrown AND no one handed him the aux cord so I'd sayÃ¢â¬Â¦ https://t.co/zSCVn5Jpah
325                                                                                                                                                                                                                  We laid on this blanket all day @ Volunteer Park https://t.co/LftwKB0q3h
326                                                                                                                                                                             @freakboy3742 The irony? @VirginAmerica fucks you overÃ¢â¬Â¦ So you pay them more. Nuts, but understandable.
327                                                                                                                                                            How long can I go without wearing the same T-shirt twice? DAY 200!!! Requin, Blood In The Sea @Ã¢â¬Â¦ https://t.co/J5wINBO5h6
328                                                                                                                                                                                              We are all of us stars, and we deserve to twinkleÃ¢ÅÂ¨ @ Lake Union https://t.co/ZqklmQpU3n
329                                                                                                                                                                                                                       The striped people. https://t.co/1nMrkO3Kng https://t.co/zxEKTfdukZ
330                                                                                                                                                                                                   So this just happened!!! #afterworkshenanigans #kayakingÃ¢â¬Â¦ https://t.co/0ZSFRuL1fA
331                                                                                                                                                                            Ã­Â Â¼Ã­Â¼Â¸Ã­Â Â¼Ã­Â¼Â¸Ã­Â Â¼Ã­Â¿Â¯Ã­Â Â¼Ã­Â¼Â¸Ã­Â Â¼Ã­Â¼Â¸ @ Seattle Japanese Garden https://t.co/7PWCPAVLKm
332                                                                                                                                                                                                                The weather and flowers are beautiful in #Seattle. https://t.co/VGVACnEzPc
333                                                                                                                                                           I call these Taiyoken (Solar Flare). just tryna get this tan and vibe out with my other half theÃ¢â¬Â¦ https://t.co/a4fQxNOVzV
334                                                                                                                                                                                        He didn't need the disciples but he chose them. He doesn't need me,Ã¢â¬Â¦ https://t.co/6wmI2pdY6l
335                                                                                                                                                                                                                                     @magpiemorning @mkeagle @garlandmcq Well, me neither!
336                                                                                                                                                                                                                  #vegan #geek @ HeartBeet Organic Superfoods Cafe https://t.co/G6Nzd8bERL
337                                                                                                                                                                                                        Woohoo #gotg!! (@ Sundance Cinemas Seattle in Seattle, WA) https://t.co/eflQxzrVlb
338                                                                                                                                        Paddling and listening to UW Husky Softball working on earning their way to WCWS. Let's go Dawgs! #wcws #uwsoftballÃ¢â¬Â¦ https://t.co/MyxPeeA03h
339                                                                                                                                                                                                                           @mkeagle @magpiemorning @garlandmcq What the heck game is this?
340                                                                                                                                                                             Super Dawg Fans ready for Super Regional #2 with @uwsoftball @ Husky Softball Stadium https://t.co/gBIq3B9aUB
341                                                                                                                                                                                                          Seattle, you're beautiful. Ã­Â Â½Ã­Â¸Â @ Gas Works Park https://t.co/4UFTKxDcIB
342                                                                                                                                                              So much fun kayaking and having a nice cold German beer. #kayaking #sunnyinseattle @MissCheevÃ¢â¬Â¦ https://t.co/TRqwX0PuHW
343                                                                                                                                                                 My weekend pack while mom and dad play in the desert. #blazeandbritni @ Washington Park Arboretum https://t.co/5Mst9mmRyi
344                                                                                                                                                                                                                                                           @chromaticCorona uggghhh *hugs*
345                                                                                                                                                                                                                                                          @Blackmudpuppy thank youuu &lt;3
346                                                                                                                                                                                                                                                            @joliemenzel It had to be done
347                                                                                                                                                                                                                                    Enjoying the Seattle sunshine! https://t.co/VNqt3ICcY5
348                                                                                                                                                                                                                  @joliemenzel You told me that t was your mom that og called you jojo tho
349                                                                                                                                                                       @joliemenzel Hahahahaha IÃ¢â¬â¢ve been callinÃ¢â¬â¢ you jojo for YEARS. Glad the root has finally come to light
350                                                                                                                                                                                                                         @acetone_kitten there should probably be a few more at some point
351                                                                                                                                                       @mcdanielcolt1 and I rooting on the @UW_Baseball vs @USC_Baseball then off to @UWSoftball at 6! Go Dawgs!!! https://t.co/WDaCDyn1pp
352                                                                                                                                                                                                             @Blackmudpuppy doing my best to create UNSUBTLE CARTOON PROPAGANDA CHARACTERS
353                                                                                                                                                                           Can you recommend anyone for this #job in #Seattle, WA? https://t.co/jLSwnTe4En #Hospitality #Hiring #CareerArc
354                                                                                                                                                             Current view.   Go Dawgs!!   Jax is pretty much in heaven.  #huskybaseball #uwbaseball @ HuskyÃ¢â¬Â¦ https://t.co/qI88J5dNYO
355                                                                                                                                                                  Walked into a comic book store and somehow ended up with these books in my hand @ Comics Dungeon https://t.co/ASM0IxXJr3
356                                                                                                                                                                                        a handful of sweethearts of the revolutionary struggle for @acetone_kitten https://t.co/ztKgbp3aKF
357                                                                                                                                                                                                    Can't even! #puppy #beaglechihuahua @ Apple University Village https://t.co/tS4Q99Lixa
358                                                                                                                                                                                               It's finally beginning to feel like Summer!!?? @ University Village https://t.co/1KXBvjpDH8
359                                                                                                                                                              Keep seeing these around Seattle. Not sure where they come from. This was in the water tower.Ã¢â¬Â¦ https://t.co/sOQIHldOpU
360                                                                                                                                                                                                                 The food is so good! @ Dick's Drive In Restaurant https://t.co/8NmqlvyKuj
361                                                                                                                                                                                                                The cost is so cheap! @ Dick's Drive In Restaurant https://t.co/MfHGj9j6RY
362                                                                                                                                                                                                         Conflict - Brooke Eva\n#leica #cinestillfilm @ Park Vista https://t.co/a8keyqVX3Q
363                                                                                                                                                        Dick's Drive In just might be my new favorite Seattle restaurant Ã­Â Â½Ã­Â±Å @ Dick's Drive In Restaurant https://t.co/QFYxeM29f6
364                                                                                                                                                                                        Thanks to every single one of you who made it out last night to seeÃ¢â¬Â¦ https://t.co/k7Acdq8BRe
365                                                                                                                                                                                           If we all worked together, we could eliminate shrieky barky little dogs and their awful owners.
366                                                                                                                                                                                                    Cheering on @p_h_i_a_ in the state tennis final! You got this! https://t.co/YWwgiufRHc
367                                                                                                                                                                Watching @SeattleReignFC on @lifetimetv at the Shelter Lounge after pedaling on Green Lake.Ã¢â¬Â¦ https://t.co/QprzL0OG59
368                                                                                                                                                                                                                                   Hipsters' motto :) @ Lake Union https://t.co/TU5ewy7Tva
369                                                                                                                                                                                                  Accident cleared in #Seattle on I-5 NB south of 45th St #traffic https://t.co/12UyGMOG9h
370                                                                                                                                                                       HeartBeet is here to fuel your body with all the good things!  \n\n#heartbeethealthyÃ¢â¬Â¦ https://t.co/pf241JRqXH
371                                                                                                                                                                                                                            @lostinfont Hmmm...if I did it was loooong ago. Love the book!
372                                                                                                                                                             Left our hearts on TQ's houseboat in Seattle. As usual. #memorialdayweekend #tourcation @ LakeÃ¢â¬Â¦ https://t.co/WbPPzGPT1d
373                                                                                                                                                                                                                                        I'M ON A BOAT @ Lake Union https://t.co/jm6dhmtAv3
374                                                                                                                                                                                         We got to see each other, him and Rylee are getting here and JaydeÃ¢â¬Â¦ https://t.co/wg3PaRadYC
375                                                                                                                                                                                                            It's gorgeous in Seattle!! @ Washington Park Arboretum https://t.co/tOw5tRfYca
376                                                                                                                                                                                                         We've got the dreamer's disease Ã­Â Â½Ã­Â·Âº @ Lake Union https://t.co/poIAeQCwrE
377                                                                                                                                                           And that's a wrap! What a phenomenal day for deployment and year for success! Congratulations toÃ¢â¬Â¦ https://t.co/LJagN6rdT6
378                                                                                                                                                                                                                       Damn you auto correct for not allowing me to spell huge with a Y...
379                                                                                                                                                           Appeal, interest and beauty are often a result from imperfections. Not from the absence of them.Ã¢â¬Â¦ https://t.co/SI34SftJks
380                                                                                                                                                            15s coaches Barb and Mikaela strategizing on the first day of ECC! Ended up undefeated day one!Ã¢â¬Â¦ https://t.co/8jRidMCeya
381                                                                                                                                                                               Writing with the sun in Seattle. #soulstoriesproject #gopublicuw @ Ravenna, Seattle https://t.co/giwXIpZ9dE
382                                                                                                                                                            Merry Christmas, Dad! Sorry it took six months to finally get some get weather so we could fly.Ã¢â¬Â¦ https://t.co/UtQAea0uGi
383                                                                                                                                                                                                                                          Is Nashville really a hockey town? @NHLtoSeattle
384                                                                                                                                                                                                                   Let's take a ride with the windows down.Ã¢â¬Â¦ https://t.co/N7enV78847
385                                                                                                                                                                                                        Artificial rain cause ITS SO NICE OUT! #ERIS2017 @ UW ERIS https://t.co/zfZHzbaOeK
386                                                                                                                                                                                                                  @ReignFC dash got nothin... go Reign #LetitReign https://t.co/UcI6HtBmdN
387                                                                                                                                                      See our latest #Seattle, WA #job and click to apply: Grassroots Marketing and Event Coordinator - https://t.co/T01ODOw9fG #Marketing
388                                                                                                                                                   Where else would you rather be at 6pm than right here tonight @UWSoftball vs @Utah_Softball #go-purple #be-gold https://t.co/XcqNwVKipa
389                                                                                                                                                                                                                   Student explanations BEFORE #ERIS2017 @ UW ERIS https://t.co/aKFDHSaKmL
390                                                                                                                                                                                                                                  Here we go!! #ERIS2017 @ UW ERIS https://t.co/xyRyGdkKyd
391                                                                                                                                                                                                                   Picnic lunch at Gasworks Park! @ Gas Works Park https://t.co/Kpu1rAwAaV
392                                                                                                                                                    From mostly meats to just veggies, weÃ¢â¬â¢ve got the pi to satisfy your craving. Check out our menu:Ã¢â¬Â¦ https://t.co/EAYBu2fPy6
393                                                                                                                                                                              "At last the sun rushed headlong into the ocean's waves, and the night rose up from the same waters." --Ovid
394                                                                                                                                                                                             Row, row, row your Blinky Ã­Â Â½Ã­Â»Â¶ @ Waterfront Activities Center https://t.co/dcZS0laUn8
395                                                                                                                                                         We're #hiring! Click to apply: IT Analyst-Database Administrator - https://t.co/kb18qJuIC7 #IT #Seattle, WA #Job #Jobs #CareerArc
396                                                                                                                                                                                       So Proud of these 6 Young Men for the Show you all Put on last NightÃ¢â¬Â¦ https://t.co/qsRMqpJrtl
397                                                                                                                                                                                                              The BASIC sensors group is streaming data! @ UW ERIS https://t.co/MwqOmPD0G3
398                                                                               The Album #OneWeek Ã­Â Â¼Ã­Â¼Â Ã­Â Â½Ã­Â²âÃ¢Å¡Â°Ã­Â Â½Ã­Â²Â°Ã­Â Â½Ã­Â´Â¥ September 14th, Ã­Â Â¼Ã­Â¼Å½-wide everywhere......Thank you Ã­Â Â½Ã­Â¸ÂÃ­Â Â½Ã­Â²Â¯ @ UniversityÃ¢â¬Â¦ https://t.co/RsOqGSnz1m
399                                                                                                                                                                                                                                 @jonasdoesstuff @_GreyWhite poutine as big as a COOL TEEN
400                                                                                                                                                                                                                This place is beautiful! @ Seattle Japanese Garden https://t.co/qKACgV1jKE
401                                                                                                                                                                                                                  Good life choices @ The Essential Baking Company https://t.co/Hy2v8Cxo4F
402                                                                                                                                                                        Last night definitely did not suck. Thanks job and friends corrlets #siff #80spartyÃ¢â¬Â¦ https://t.co/jj0W7aVtU2
403                                                                                                                                                           "SFIT-man"\n.\n#JetCityImprov #TShirtArt #SFIT2017 #Seattle #ImprovTheater #Macho #InternationalÃ¢â¬Â¦ https://t.co/uhdS0J3t2c
404                                                                                                                                                                                              Spending our 3 day weekend at UW watching the girls play!! #2Ã¢â¬Â¦ https://t.co/L2y8Vc9BiJ
405                                                                                                                                                                    Friday (apparently weekly) happy hour with Deborah. How else would we make it thru thisÃ¢â¬Â¦ https://t.co/QWOBQ5fqVl
406                                                                                                                                                                                                                                   I'm at Starbucks in Seattle, WA https://t.co/JWnaD5eNo8
407                                                                                                                                                                                                                                 I'm at Bagel Oasis in Seattle, WA https://t.co/9rzm0ZTAnb
408                                                                                                                 #OneWeek Ã­Â Â¼Ã­Â¼Â Ã¢Å¡Â°Ã­Â Â½Ã­Â²ËÃ­Â Â½Ã­Â´Å......This is tha album &amp; I'm ready to release this summer/fall  (Re-done more thanÃ¢â¬Â¦ https://t.co/FwqBAaxZzv
409                                                                                                                                                                                                                                                 @niceguyscott @AChrisSummers is there too
410                                                                                                                                                                                                                                        Aurora bridge @ Lake Union https://t.co/WkWzOtIzZa
411                                                                                                                                                                                                                                                   @ARishi_ IÃ¢â¬â¢m always disgruntled.
412                                                                                                                                                     This #job might be a great fit for you: Urgently Seeking an Emergency Room RN - https://t.co/V5iXBRiOFD #Nursing #Seattle, WA #Hiring
413                                                                                                                                                                                                              I'm at Gas Works Park - @seattleparks in Seattle, WA https://t.co/LwnUrjRllk
414                                                                                                                                                                         Walking down Memorial Way on Memorial Day weekend Ã­Â Â¼Ã­Â½Æ @ University of Washington https://t.co/ACIw1LvTZA
415                                                                                                                                                                                   @rectangular but thatÃ¢â¬â¢s the thing, scientific theories are still theories and not absolute fact.
416                                                                                                                                                                                                        smart people ditched googleÃ¢â¬â¢s shit a long time ago. https://t.co/RvWqzJCHBN
417                                                                                                                                                                                                                Just posted a photo @ Lake View Cemetery (Seattle) https://t.co/lKryuK3Xyh
418                                                                                                                                                                                                        Nike Air Force 1 Supreme "Wilkes" #af1 #airforce1 @ Recess https://t.co/EWHRKcMj47
419                                                                                                                                                      #TypeScript: the Fun Parts - A video about this relatively-new programming language that extends #JavaScript https://t.co/m2u6uCsqzN
420                                                                         What an amazing game!!!! DAWGS 10 Utah 4! #win #purplegold #supers #espn Ã­Â Â½Ã­Â²ÅÃ­Â Â½Ã­Â²âºÃ¢Å¡Â¾Ã¯Â¸ÂÃ­Â Â½Ã­Â±ÂÃ­Â Â¼Ã­Â¿Â¼Ã¢ÅÂ¨Ã¢ÅÂ¨Ã¢ÅÂ¨Ã¢ÅÂ¨Ã¢ÅÂ¨Ã¢ÅÂ¨ @ HuskyÃ¢â¬Â¦ https://t.co/lF54Wxz53M
421                                                                                                                                                            Spending Saturday night covering NCAA Super Regionals, Utah vs UW, for Deseret News in Salt Lake City. https://t.co/oQF4GkZJhJ
422                                                                                                                                                                                         Just another night and another Dolla. #workflow. It's #fridaynightÃ¢â¬Â¦ https://t.co/sAs1X6Yrdz
423                                                                                                                                                                                                                            Air Jordan 2 "Candy Red" $250 @ Recess https://t.co/2p4DJIP6it
424                                                                                                                                                                                       Drinking a Trickster by @blackravenbrew at @joeyrestaurants Ã¢â¬â https://t.co/tZaHmKgsGj #photo
425                                                                                                                                                                      @Utah_Softball players still racist AF doing the goddamned hand to mouth war woot. #RoadToWCWS @espnW #NotYourMascot
426                                                                                                                                                                                                                                       i am finally happy again!!! https://t.co/HEwOd6VmZp
427                                                                                                                                                Show #72: "Crumble (Lay Me Down Justin Timberlake)".  Second show of the UW Drama Lab's... https://t.co/zbtA7YtrTt https://t.co/kMw8eX9a2d
428                                                                                                                                                                                                             "Friday" means "Chicken nachos"... @ Eureka U Village https://t.co/VPolEr0PCY
429                                                                                                                                                                                                                                             Da road @ I-5 Freeway https://t.co/pSyB1GFwJo
430                                                                                                                                                                  On our way to #BYC #bremertonyachtclub #washington #boating #yacht #rainieryachtclub #RYCÃ¢â¬Â¦ https://t.co/y2tDNRi2RX
431                                                                                                                                                                                                                                            Yup!! @ Volunteer Park https://t.co/ajd1fB3JkK
432                                                                                                                                                     Lantana flower #flowertattoo #lantana  #seattle #seattletattoo #seattletattooartist #seattletattooshopÃ¢â¬Â¦ https://t.co/T4n6LVhGKv
433                                                                                                                      @Robot_Joe ThereÃ¢â¬â¢s a point where I just say Ã¢â¬Åfuck itÃ¢â¬Â and either slack off drawing and do something else, or startÃ¢â¬Â¦ https://t.co/MZLBjpBikH
434                                                                                                                                                                                                                    Follow the crow @ Lake View Cemetery (Seattle) https://t.co/WnAsUPBpia
435                                                                                                                                                                                        Found ourselves in the cemetery again! So goth @ Lake View CemeteryÃ¢â¬Â¦ https://t.co/McxamW0YxX
436                                                                                                                                                                                                                                   I'm at Starbucks in Seattle, WA https://t.co/yLcSjhbIeT
437                                                                                                                                                                                        What to do while making a 1-hour monitoring video with a stationaryÃ¢â¬Â¦ https://t.co/HpjHjI9qKb
438                                                                                                                                                                                        Checking on our #floatingwetland #fieldwork #gradstudentlife @ AguaÃ¢â¬Â¦ https://t.co/sld4KkUnGK
439                                                                                                                                                                                                                                                         Happiness https://t.co/SHSSwOuAIN
440                                                                                                                                                                                                              Drinking a Haze Craze by @theRAM at @theram Ã¢â¬â https://t.co/Y4EmN11DTl
441                                                                                                                                                              Success! So fun out there today! And beautiful weather for #bikeeverywhereday 2017! @ ClassicÃ¢â¬Â¦ https://t.co/8AEybiESuQ
442                                                                                                                                                                           Because every girl who endures bathing suit shopping deserves an ice cream cone.Ã¢â¬Â¦ https://t.co/h6fnF1fgZH
443                                                                                                                                                                                                                                                @zoocoup There you go, assuming either/or.
444                                                                                                                                                                                                                                         Balance. @ Volunteer Park https://t.co/7GnlJdTDxN
445                                                                                                                                                                                                              @george_llevi I'd use my bare feet to crush his grapes if you know what's up
446                                                                                                                                                                                                                  The #longweekend begins. https://t.co/5XxXrTki1V https://t.co/79kKU7XBLo
447                                                                                                                                                Happy Friday, here's a gallery of slow-mo pictures of my dog catching a ball, please enjoy https://t.co/7deuTn6zTA https://t.co/ANq8p3sRGj
448                                                                                                                                                             Left on the patio by one of our smaller guests...           #seattle #patio #chalk #margaritasÃ¢â¬Â¦ https://t.co/2nEXD2T2vx
449                                                                                                                                                                                                      Sigh. Lunch is over! :-) @ Agua Verde Cafe &amp; Paddle Club https://t.co/41fiQUGJ8S
450                                                                                                                                             And yes, IÃ¢â¬â¢m mildly miffed that apparently you canÃ¢â¬â¢t run a business in 2017 without a fax number. Sigh. https://t.co/kufy670ghD
451                                                                                                                                    Anyone have good experiences with fax -&gt; email online services (where weÃ¢â¬â¢d have a number assigned, and any fax would be forwarded to email)?
452                                                                                                                                                                        See our latest #Seattle, WA #job and click to apply: Store Counter Sales - #hiring #career https://t.co/2SXakkfck9
453                                                                                                                                                                  Nothing but #love for my little #nephew #puppy mondoandme aimeedaileyfallat #sheepadoodleÃ¢â¬Â¦ https://t.co/ObRTNDEsCG
454                                                                                                                                                                 I was gonna call this a snack, but let's be honest... hashtag lunch part 2! #snacks #paleoÃ¢â¬Â¦ https://t.co/NKgva9zUzO
455                                                                                                                                                                         There is no place more beautiful than #seattle on a sunny day. #uw #lakewashingtonÃ¢â¬Â¦ https://t.co/DZRmaoXIWD
456                                                                                                                                                                                                                    I'm at Apple University Village in Seattle, WA https://t.co/Wbth1V5C8L
457                                                                                                                                                                                                                              I'm at @AguaVerdeCafe in Seattle, WA https://t.co/jWhVpwdKz6
458                                                                                                                                                                                                                             This guys wins today @ Volunteer Park https://t.co/wrNOqTrauY
459                                                                                                                                                                               Who doesn't love bioluminescent bacteria? @ University of Washington Medical Center https://t.co/e3gblWmefC
460                                                                                                                                                                      DenimÃ­Â Â½Ã­Â±â #sonics #supersonics #seattle #seattlesonics #seattlesupersonics @ Recess https://t.co/Icp549fLTo
461                                                                                                                                                                                                             1 hour after I posted this tweet I was invited to a Yoga with Goats Event WHY
462                                                                                                                                                               Love and deco / excited to post some new engagement sessions and wedding pictures soon. It'sÃ¢â¬Â¦ https://t.co/dhA1nUl1bf
463                                                                                                                                                                                          Entrance to Lake Washington with Cascades the background. @ Montlake Cut https://t.co/Qf62rKo8YE
464                                                                                                                                                                                                                         Canoe selfie! @ Washington Park Arboretum https://t.co/Z4aNoVPCOW
465                                                                                                                                                              Listening to The Beach Boys and realizing that @odesza sampled Our Prayer for Keep Her Close. I SEE YOU ODESZA! Ã­Â Â½Ã­Â¸Â
466                                                                                                                                                                                                             .@central_coop announces new Tacoma lease in West End https://t.co/cklCEkGGwR
467                                                                                                                                                                                                         Now I know why @john_harper's twitch streams are so loud. https://t.co/YcJjJXZZru
468                                                                                                                                                  Cute birds #3littlebirds #birdtattoo #scripttattoo #lyricstattoo #bobmarleylyrics #seattle #seattletattooÃ¢â¬Â¦ https://t.co/pjml93mQ98
469                                                                                                                                                              What could be better than a smoothie bar at work?  You hooking up your office with a smoothieÃ¢â¬Â¦ https://t.co/2DyuG0fZFa
470                                                                                                                                                                                                                                     I need you back in my life... https://t.co/9GuGsHj7qa
471                                                                                                                                                                                                                     Just posted a photo @ Seattle Japanese Garden https://t.co/tUBce1KWLw
472                                                                                                                                                                                                                    We rented a canoe. @ Washington Park Arboretum https://t.co/NOAQHjvqQd
473                                                                                                                                                                                                                                   This is a rewarding short read. https://t.co/xXtboNzAqJ
474                                                                                                                                                                                                                         Call me Ishmael @ Seattle Japanese Garden https://t.co/SceWt07QJc
475                                                                                                                                                                                                                     Just posted a photo @ Seattle Japanese Garden https://t.co/YqFU6qfWpr
476                                                                                                                                                                                                                     Just posted a photo @ Seattle Japanese Garden https://t.co/8yqgQRi7Ag
477                                                                                                                                                                                                                     I'm at Seattle Japanese Garden in Seattle, WA https://t.co/igLrubVpLd
478                                                                                                                                                                                                I'm at Washington Park Arboretum - @uwbotanicgarden in Seattle, WA https://t.co/BmuCq2UhWy
479                                                                                                                                                 Accident cleared to the right shoulder. in #Seattle on I-5 SB approaching 45th St, stop and go traffic back to N 92nd St, delay of 7 mins
480                                                                                                                                       donÃ¢â¬â¢t see many devs talking about this, but using xcode playgrounds for prototyping and testing styles is excellent: https://t.co/FEluy3qkBh
481                                                                                                                                                           Accident, left lane blocked in #Seattle on I-5 SB approaching 45th St, slow traffic back to N 92nd St, delay of 2 mins #traffic
482                                                                                                                                         Our gorgeous FULLY Renovated Kelsey Apartments are now Sold Out for Fall Quarter! We cannot wait to welcome all ofÃ¢â¬Â¦ https://t.co/vFg8KDQy3T
483                                                                                                                          Ã­Â Â½Ã­Â´Â¥Ã­Â Â½Ã­Â´Â¥Ã­Â Â½Ã­Â´Â¥\n#rutaceae #dictamnusalbus #dictamnus #burningbush @ University of Washington Medicinal HerbÃ¢â¬Â¦ https://t.co/p7aYgFb9Th
484                                                                                                                                                                                          #asteraceae #compositae @ University of Washington Medicinal Herb Garden https://t.co/XYUZE1gidS
485                                                                                                                                                                     #sterculiaceae #fremontodendron #flannelbush @ University of Washington Medicinal Herb Garden https://t.co/UOuQCTV7Q3
486                                                                                                                                                                   #iridaceae #iris #douglasiris #irisdouglasiana @ University of Washington Medicinal Herb Garden https://t.co/SzDZPTailk
487                                                                                                                                                                              already lacked motivation for anything on the computer today, but this weather is making it that much worse.
488                                                                                                                                                                         #scrophulariaceae #mimulus #monkeyflower @ University of Washington Medicinal Herb Garden https://t.co/JAno0XZZdA
489                                                                                                                                                                                    #portulacaceae #minerslettuce @ University of Washington Medicinal Herb Garden https://t.co/mMU3JU1vzx
490                                                                                                                                                                         Valerian and the city of a thousand teeny tiny flowers. \n#valerian #valerianaceaeÃ¢â¬Â¦ https://t.co/Hi304ZCFVG
491                                                                                                                                                                                                                              my work here is done #friday #fuckit https://t.co/QLKcAqtL1Y
492                                                                                                                                                                                                                             @dalbright definitely going to die on this hill. keep trying!
493                                                                                                                                                                                              Good to see @SeaGlobalist media workshops make the list for citywide https://t.co/kYjfU03TYv
494                                                                                                                                               Yo why is everyone trynna do yoga w/ animals roaming around them? sounds stressful af what if you stepped on a kitten tail in Downward Dog?
495                                                                                                                                                                                                      The phrase of the day is "paratactical crudity", a delight revealed to me by @kdrum.
496                                                                                                                                                                                                              GOOGLE PHOTOS MADE A GIF OF MY GOLDEN DAYS VIDEO BYE https://t.co/ZNLJBQk94X
497                                                                                                                                                                                                                                 We're all using Instagram instead of Snapchat now, right?
498                                                                                                                                                                            Outdoor seating waiting for you #atthehenry #uwseattle #udub @ City Grind at The Henry https://t.co/c9ne4yVvsx
499                                                                                                                                                                                                                                             Having a "tiny latte"-style macchiato. ***1/2
500                                                                                                                                                  Want to work at Einstein Bros. Bagels? We're #hiring in #Seattle, WA! Click for details: https://t.co/8cTYchVFF7 #Hospitality #Job #Jobs
501                                                                                                                                                                                                                          Friday mornings Ã­Â Â½Ã­Â±ÂÃ­Â Â¼Ã­Â¿Â½ https://t.co/PYJQTqlx0Y
502                                                                                                                                                                       You know what time it is, #floatfriday time! \n\n#peacemode #Seattle #goodforthemindÃ¢â¬Â¦ https://t.co/JjfQgvpwV2
503                                                                                                                                                                                        This #job might be a great fit for you: Cook - https://t.co/oUb6VAAXwB #Labor #Seattle, WA #Hiring
504                                                                                                                                         Friday morning coffee on the deck at work. Seaplanes and kayaks and paddleboards, oh my! I need to be up here moreÃ¢â¬Â¦ https://t.co/hO4y0VYccq
505                                                                                                                                                                       go figure, study finds Ã¢â¬Åextensive facebook usage decreases health + happinessÃ¢â¬Â: https://t.co/tmQsPlEJ5p
506                                                                                                                                                                                                          if you want to be creative, donÃ¢â¬â¢t be data driven: https://t.co/aFRqEUHVBH
507                                                                                                                                                                            @jdriscoll It's funny that you say that. Mine likes exactly what I liked, PokÃÂ©mon Ã­Â Â½Ã­Â¸â¦Ã­Â Â½Ã­Â¸Â¬
508                                                                                                                                                                                                                                 40% Off at Night Light Nail Salon https://t.co/LLIzROV6ve
509                                                                                                                                                                                    Happy 2nd bday Multi-Love, you've been with me since the KY days Ã­Â Â½Ã­Â²â https://t.co/e2Dq39Ujxh
510                                                                                                                                                                                                                                   Meat and drinks with The Dudes. https://t.co/Jd6lnuvLOd
511                                                                                                                                                                Yea Me, knee surgery\n#notevensurewhatnumberthisis #paininthebutt #oopsimeanknee #greatmedsÃ¢â¬Â¦ https://t.co/IQePrrafmw
512                                                                                                                                                                                      @melaniemj HeÃ¢â¬â¢s a little young for coffee, but this mug is excellent: https://t.co/biEHu6XYTE
513                                                                                                                                                                                                @equach206 and I need to start a business...2nd  gig in 2 weeks... https://t.co/zfObPJNIF0
514                                                                                                                                            Thank you to our Tyee Club Champions Circle members. Wonderful night hosting you all on the 50 of #HuskyStadiumÃ¢â¬Â¦ https://t.co/uvez23AC43
515                                                                                                                                                                                                          Cheers to the last team meeting of year one of our MBAs! https://t.co/B1OD3Cwpuz
516                                                                                                                                                                              These dudes&lt;3\njeremyr754 corywilkie \n#mybrothers @ University District, Seattle https://t.co/8J0iADG4Vy
517                                                                                                                    Roommates + boat + Space Needle = dabest Ã­Â Â¾Ã­Â´âÃ­Â Â½Ã­Â´Â¥Ã­Â Â½Ã­Â¸Â½ (100th Ã­Â Â¼Ã­Â¾â°) \n#lakeunion #seattle #spaceneedleÃ¢â¬Â¦ https://t.co/TXbVxHVaq7
518                                                                                                                                                                                               DLO3 &amp; The Extraordinaires (@ SeaMonster Lounge in Seattle, WA) https://t.co/joz1R4v7n0
519                                                                                                                                                                 Donald Craig (below left) generating live digital sound/images, UW Alumni Alchemy @GoodShepChapel https://t.co/bvQMYoovmd
520                                                                                                                                                                                                                                                       @thomas_violence Fucken SUBSCRIBE'D
521                                                                                                                                                                         so even though plans don't always work out, any time spent with @okaynicolita is the best https://t.co/7eghm41Eov
522                                                                                                                                                                                                                  Some really interesting UI design going on here: https://t.co/A50aBYEfTU
523                                                                                                        Spanish table Ã­Â Â¼Ã­Â·ÂªÃ­Â Â¼Ã­Â·Â¸ on Montlake Ã­Â Â½Ã­Â±Â¨Ã¢â¬ÂÃ­Â Â¼Ã­Â½Â³\n.\n.\n.\n#food #foodporn #cook #cooking #spain #paella #seafoodÃ¢â¬Â¦ https://t.co/h6Dow2hJ6i
524                                                                                                                                                                                           #floatingwetland 'predator cage' has been deployed! @ Agua VerdeÃ¢â¬Â¦ https://t.co/lOTyML5OY3
525                                                                                                                                                                 Gotta love free pre-screenings! #prescreening #thebigsick #thebigsickmovie #kamailnanjianiÃ¢â¬Â¦ https://t.co/ECQ19Z0tAJ
526                                                                                                                                                              By far the best burger I've had in Seattle and the nicest owner! Thanks for the birthday beerÃ¢â¬Â¦ https://t.co/rTFit3sgtj
527                                                                                                                                                                       This place was really cool.\n#seattle #gasworkspark #10thingsihateaboutyou @ Gas Works Park https://t.co/pYODWTHj3y
528                                                                                                                                Ooooh, the effin' mysteryÃ¢â¬Â¦Ã­Â Â½Ã­Â±Â»Ã­Â Â½Ã­Â¸Â±#workingartist #oilpainting #gageacademy #kohatelier @ Gage AcademyÃ¢â¬Â¦ https://t.co/CxtlmV57Pe
529                                                                                                                                                                               City dog Ã­Â Â½Ã­Â²â¢Ã­Â Â½Ã­Â²Å¡ #LolatheBoxer #TaillessTraveler @ Gas Works Park https://t.co/vLdepX3cu7
530                                                                                                                                                                               Hanging with @latonapub &amp; @reubensbrews with this #Cucumber #Gose. @ Latona Pub https://t.co/wmM4fRuscp
531                                                                                                                                                                                   Pretty perfect Ã­Â Â½Ã­Â²â¢ #Seattle #gasworkspark #lakeunion @ Gas Works Park https://t.co/t0M3F270pi
532                                                                                                                                                                                                            Didn't flip the canoe!! @ Waterfront Activities Center https://t.co/t8UwUXEgAe
533                                                                                                                                                                  If you're looking for work in #Seattle, WA, check out this #job: https://t.co/DA9RSU3zTH #Hospitality #Hiring #CareerArc
534                                                                                                                                                             hoopofficial  time to use this in games.  #oaklandrebelsblack2023 @ Ravenna-Eckstein CommunityÃ¢â¬Â¦ https://t.co/jINwiiPpho
535                                                                                                                                                  Want to work at Einstein Bros. Bagels? We're #hiring in #Seattle, WA! Click for details: https://t.co/sha3Y4Ont1 #Hospitality #Job #Jobs
536                                                                                                                                                                                                                                        @J_Treble What shoes you wearing out there though?
537                                                                                                                                                                                                                       Baerlic Test Flight Session India Pale Ale  https://t.co/nn8he2xzl9
538                                                                                                                                                                                                                     not sure i can bear sitting in front of a computer anymore this week.
539                                                                                                                                                                                                                              @skydart @Xbox @Microsoft Ha they got you on this?! Awesome!
540                                                                                                                                                                                                                                      Yo @macklemore is that you?? https://t.co/kbBfElT4NY
541                                                                                                                                                                                        The current music playing in our demo room is the theme music from Star Trek: The Next Generation.
542                                                                                                                                                                                  Welp, I'm crying Ã­Â Â½Ã­Â¸Â­Ã­Â Â½Ã­Â¸Â­Ã­Â Â½Ã­Â¸Â­ @ University of Washington https://t.co/EoQVtZG8sK
543                                                                                                                                              @waltmossberg Been a real pleasure reading your columns and listening to your #ControlWaltDelete podcasts! Hope you have a great retirement!
544                                                                                                                                                                                                                                                                 @sehurlburt I would teach
545                                                                                                                                                                                                                                                        nailed it. https://t.co/RpAMkrHHRt
546                                                                                                                                                                    #tbt to Seattle with these weirdos. I think it's time for another adventure, don't you?Ã¢â¬Â¦ https://t.co/XAuQCIaJIi
547                                                                                                                                                                      We're #hiring! Click to apply: Housekeeper - https://t.co/uz8kecOtj0 #Hospitality #Seattle, WA #Job #Jobs #CareerArc
548                                                                                                                                                                                                              I'm at @JambaJuice University Village in Seattle, WA https://t.co/JNpU6Sdcu1
549                                                                                                                                      Ã­Â Â¼Ã­Â¾Â¶my devil's only closer when I call him backÃ­Â Â¼Ã­Â¾Â¶\n//Context found in Noname's "Yesterday"\n(WHICH,Ã¢â¬Â¦ https://t.co/nXkyxoEluo
550                                                                                                                                                                                    Furniture porn (@ Restoration Hardware in Seattle, WA) https://t.co/YFxfZDA5Tq https://t.co/9au37heVyg
551                                                                                                                                                                                                                    Ã¢Å¡Â¡Ã¯Â¸ÂÃ¢Å¡Â¡Ã¯Â¸ÂÃ¢Å¡Â¡Ã¯Â¸Â @ Chatime https://t.co/iO6D74um8m
552                                                                                                                                                              Are you truly committed to your goals?  Will you do what it takes to reach them?  Think aboutÃ¢â¬Â¦ https://t.co/rD6ZV2MZAg
553                                                                                                                                                                 Trying to let my inner and outer self let go. Getting back to my practice and loving everyÃ¢â¬Â¦ https://t.co/MBV0VPGYB0
554                                                                                                                                          Lunch. Catching up on news, &amp; watching #AFLCatsPower. I'm at Pavilion Espresso (Surgery Pavilion, UWMC, Seattle, WA) https://t.co/D3Tkz3cHpv
555                                                                                                                                                                                                                        Baerlic Lightweight Double India Pale Ale  https://t.co/kwbQ44o9Zw
556                                                                                                                                                                             Uhm... #UW what is this? I mean like seriously #bishwhet?? @ University of Washington https://t.co/elONzDDQCY
557                                                                                                                                                             'Lead Generation will find a sale; lead follow-up will find a business.' ~Cody Gibson, May 25,Ã¢â¬Â¦ https://t.co/LAjvOSLqHL
558                                                                                                                                              Fuck this #Subway \nNeither of the employees here listened to me. I made an order. The cashier was on the phone while I checked out. @SUBWAY
559                                                                                                                                                           My little big brother competes this weekend in the triple jump in Austin, Texas for regionals toÃ¢â¬Â¦ https://t.co/7nciwMCdIl
560                                                                                                                                                                                                                            I'm at Room &amp; Board in Seattle, WA https://t.co/uSTPva6us7
561                                                                                                                                                                                                                          I'm at University Village in Seattle, WA https://t.co/P2cLFIKheV
562                                                                                                                                        @TechGrlTweeter @fitbit Are you pursuing a particular goal? @macjustice convinced me to try Life Cycle in the phoneÃ¢â¬Â¦ https://t.co/h6s233x7qc
563                                                                                                                                                                                                                   Just a #bird at work @ Apple University Village https://t.co/hLej0TFWw2
564                                                                                                                                                                                                                          I'm at University Village in Seattle, WA https://t.co/PZO2jEyEWx
565                                                                                                                                                                                         Current mood at work #prettyinpink #happydayÃ­Â Â½Ã­Â²â¢ @ Beehive Salon https://t.co/whYjiqNFOW
566                                                                                                                                                                                                                                                           PErFECT https://t.co/O1cgbBbHNU
567                                                                                                                                                                                                                                                               queer positive slut shaming
568                                                                                                                                                                                                                 happy almost dead week Ã­Â Â½Ã­Â²â¬Ã­Â Â½Ã­Â²â¬ https://t.co/M9oG112mVB
569                                                                                                                                Pro tip: Spice up your conversations by adding the adjective Ã¢â¬ÅhumanÃ¢â¬Â in front of any activity. \nEx. IÃ¢â¬â¢m going to grab some human food.
570                                                                                                                                                                                                                @raincitygeek Ive got a wifi sous vide and that makes sense I thinkÃ¢â¬Â¦
571                                                                                                                                                      @grahamruthven IÃ¢â¬â¢ve done it so many times and then can never bring myself to play it. IÃ¢â¬â¢m past that period of my life.
572                                                                                                                                                          #soupson \nCoconut Red Lentil Dal\nChicken and Apricot Masala \n#atthehenry #udub @ City Grind atÃ¢â¬Â¦ https://t.co/lKQQ8hlact
573                                                                                                                                                                    Sharing with UW what #harmreduction is and why #phra rules Ã¢ÂÂ¤Ã¯Â¸Â @ Husky Union Building https://t.co/BQfpX4bNZV
574                                                                                                                                                                                   Lake Washington and Evergreen Point Floating Bridge. @ University of Washington https://t.co/9pjrjxOFyP
575                                                                                                                                                                                 spotted this gem on the way to my lab this morning @ University District, Seattle https://t.co/Iq2o9dMzwg
576                                                                                                                                                                                                                                                  @_GreyWhite These days I mostly use Ion.
577                                                                                                                                                               Urban foraging find today - a cluster of Shaggy Parasol's (aka Chlorophyllum rachodes) foundÃ¢â¬Â¦ https://t.co/0DCPV8QXuz
578                                                                                                                                           @PartyPrat WEÃ¢â¬â¢RE GOING TO THE MOOOoooÃ¢â¬âÃ¢â¬â oh.\n\n*gets some popcorn and waits for bitcoin to finish bouncing down the cliff*
579                                                                                                                                                                                        @MaraWilson dude fucken right? in my experience Trunk Club had an easier time grasping the concept
580                                                                                                                                        Capitol Hill Community Post | S.A.F.E applauds the victory at Midtown Center; pledges to move forward with fightingÃ¢â¬Â¦ https://t.co/ObLD4NoQZ6
581                                                                                                                                                                       If you're looking for work in #Seattle, WA, check out this #job: https://t.co/gUHO9qa4qF #Retail #Hiring #CareerArc
582                                                                                                                                                                                                     There's already so much mixed-up development in the city, tho https://t.co/yXUZPdgcUP
583                                                                                                                                                                                                                                      welcome high-income readers! https://t.co/WEQQVGrtu4
584                                                                                                                                                                                                                                                       bad news :( https://t.co/33MjSEpBtF
585                                                                                                                                                                                                   @dustbiddy @ObeseChess @heelersbot @polytraveller No, though it does look just like her
586                                                                                                                                                                                                                                                                    @MITorres That worked!
587                                                                                                                                                                 The weather is going to be awesome!  Come fill your sun-kissed bellies with a bowl full ofÃ¢â¬Â¦ https://t.co/Gb82UmlQh5
588                                                                                                                                                                             Will make it a point to do happy hour here this summer Ã­Â Â¼Ã­Â¿â #WestWardSeattle https://t.co/njSxL2zep0
589                                                                                                                                                                                                       Back to the office I go! I had fun visiting our new client. https://t.co/VjWxD8t0DT
590                                                                                                                                               My 100th edit on Wikipedia: adding Charles Kushner as a former inmate of the Federal Prison Camp in Montgomery, AL. https://t.co/6jW7GOlxLR
591                                                                                                                                                           Was a model for #microblading with mrshoots beehive_salon will be offering this service soon topÃ¢â¬Â¦ https://t.co/SvxILWphiK
592                                                                                                                                                                                               seattle is once again the nationÃ¢â¬â¢s fastest-growing big city: https://t.co/fEwyM3bawu
593                                                                                                                                                                                                   I should clarify IÃ¢â¬â¢m talking about Documents 6, @Readdle https://t.co/zHvqaNVDzB
594                                                                                                                                               Dammit. After watching a few clips of Donald Trump from 30 years ago, I'd much rather have *that* guy as president. https://t.co/NwOC1diDCh
595                                                                                                                                                                     @bfd A hash function that, even if you die, will still wait faithfully for decades to give you your results: Hashiko.
596                                                                                                                                        @SparkMailApp Is there a list of the 1500 improvements for Spark? IÃ¢â¬â¢m shocked that color coding accounts seems to have not made the cut? :(
597                                                                                                                                                             I guess this place is called Bol Test Kitchen now? Anyway, this #duck #confit #soup was yummy!Ã¢â¬Â¦ https://t.co/QFl8PWVyU1
598                                                                                                                                                 Always so tempted to pick up a hair tie someone has lost on the ground because hair ties are the most rare and valuable objects on earth.
599                                                                                                                                                                                                              I'm at UW Medical Center at Roosevelt in Seattle, WA https://t.co/i6mTiw7D9x
600                                                                                                                                                                                                                     Another Fun day of IVIG infusions. Ugh. #ivig https://t.co/G8aUOLVH48
601                                                                                                                                                             Nearly a 1/4 mile long hallway in a 3 million square foot building on UW campus. The design ofÃ¢â¬Â¦ https://t.co/THIwdjHKRd
602                                                                                                                                                                       @brijanp tweetbot is the only way to use twitter, never have to deal with the shit they constantly do to your feed.
603                                                                                                                                                             Now that the weather is *finally* nice in Seattle, I'm looking forward to a summer filled withÃ¢â¬Â¦ https://t.co/nBj4yi3Frc
604                                                                                                                                                                                                       Seattle View Point! #lights #miss #bangkok @ Gas Works Park https://t.co/2W1ocreasT
605                                                                                                                                                             We had a great night hearing and meeting @realrobbell at a book signing! We laughed and cried.Ã¢â¬Â¦ https://t.co/dqpCH1HLgg
606                                                                                                                                                              Just 100 more days until we're back out on that field #purplereign @ Alaska Airlines Field atÃ¢â¬Â¦ https://t.co/9PhtmCgMas
607                                                                                                                                                                          Got my juice cleanse delivery from Grass and Root Juice Co.! @ Washington Park Arboretum https://t.co/CwcTRdMB1A
608                                                                                                                                                              Siaire presenting the construction portion for the ACE Mentorship Program on the design buildÃ¢â¬Â¦ https://t.co/WUZR8jGWBC
609                                                                                                                                                           Summer is almost upon us!ÃÂ #gonnabewaytoowarm #sunset #seattle #seattleatdusk #scenery #natureÃ¢â¬Â¦ https://t.co/GTrMbIliJ0
610                                                                                                                                                                                                          8:36pm after work medicines. @ The Atlantic Crossing Pub https://t.co/85HMEt9ss7
611                                                                                                                                                                                         I'm honored uw_ama! Always love hanging out with you guys. Keep upÃ¢â¬Â¦ https://t.co/j7BWKn1hO5
612                                                                                                                                                                                              Not a lot of views in the world are as good as this one @ Lake Union https://t.co/8Qiy3ZCv8j
613                                                                                                                                                                                                                     IT'S HAPPENING! Good riddance to bad rubbish. https://t.co/B2Dt6Sxkgs
614                                                                                                                                                                                                                   I chose the Lake Washington Loop for my return route; I must be insane.
615                                                                                                                                                                                                 Huge benefit of being a board member at KUOW, tickets to KUOW news quiz!    #kuownewsquiz
616                                                                                                                                                                               This could have been bad #leak from the video #theydontfuckaround #SkateTv253 #film https://t.co/YizjgiJCRv
617                                                                                                                                                         My yoga instructor today refused to speak the president's name and instead referred to him as "the 45th" Ã­Â Â½Ã­Â¹ÅÃ­Â Â¼Ã­Â¿Â»
618                                                                                                                                                                              I can't possibly be expected to work when this guy visits....  Ã­Â Â½Ã­Â¸Â @Ã¢â¬Â¦ https://t.co/KSaqdLjPrJ
619                                                                                                                                                           Look who I ran into @realrobbell #booksigning in the University bookstore in #udistrict #seattleÃ¢â¬Â¦ https://t.co/xvPy2bIOtQ
620                                                                                                                                                          in my element Ã­Â Â½Ã­Â»Â¶Ã­Â Â½Ã­Â²Â¦ and happy it's finally warm in Seattle! Ã¢Ëâ¬Ã¯Â¸Â @ Union Bay https://t.co/8JdGFfDTvk
621                                                                                                                                                                                        Today I returned to the warm embrace of microbladerunner for my sixÃ¢â¬Â¦ https://t.co/HHP5oFnQw4
622                                                                                                                                                                                                                              @stigmatiic Where else would I publicly air my dirty laundry
623                                                                                                                                                                                                                                                 @stigmatiic The social network for lovers
624                                                                                                                                                                                                                           @stigmatiic @thomas_violence I am 9 feet tallÃ¢â¬Â¦ AROUND!!!!
625                                                                                                                                                                                                                                           (I know it's not drive-side I am so very sorry)
626                                                                                                                                                                  Left work early yesterday, got a nice 20 miler in. Couldn't resist a vanity shoot. #rrbinthewild https://t.co/qPO6PDd66d
627                                                                                                                                                         A hoppy porter! It's good! - Drinking a Coal Creek Porter by @BigTimeBrewery at @bigtimebrewery  Ã¢â¬â https://t.co/HAemargUrV
628                                                                                                                                                                                                              Is it just me, or does my Samsung Vibrant's #CM7 battery life suck? #Android
629                                                                                                                                                                My date for the day. Ã­Â Â½Ã­Â²â¢Ã­Â Â½Ã­Â±Â¶Ã­Â Â¼Ã­Â¿Â» \n.\n.\n.\n.\n#jasperisacutiepieÃ¢â¬Â¦ https://t.co/1XiJ3n37S6
630                                                                                                                                                                                                Happy this sidekick is back in commission. :) @ University Village https://t.co/Qufcx2YlzK
631                                                                                                                                                                                                                                                    I worked today https://t.co/EKiOe7PiaI
632                                                                                                                                                                                                                  @Phoenix_Comics Sometimes twitter is pretty cool https://t.co/a5BUIoymzy
633                                                                                                                                                                                         Spent most of the afternoon cleaning soil off some of the plants IÃ¢â¬Â¦ https://t.co/KxvAQ7fclA
634                                                                                                                                                       I'm at Seattle Children's Hospital - @seattlechildren in Seattle, WA w/ @roxy_haart https://t.co/IAfehzaypB https://t.co/BFd0hY571f
635                                                                                                                                        Ã¢â¬Åslow down: drive like you live hereÃ¢â¬Â signs in residential capitol hill apparently telling me to drive like i have millions of dollars
636                                                                                                                                                        Join the Robert Half Technology team! See our latest #job opening here: https://t.co/qDtrdipnUO #BusinessMgmt #Seattle, WA #Hiring
637                                                                                                                                                            She's the baby of the band *Wah Wah WAH* Ã­Â Â½Ã­Â³Â·: @tmnlsn #ClockThatConstruct @ Henry Art Gallery https://t.co/y0jhIvHeuV
638                                                                                                                                                                                                                      Laser cut happiness. Ã­Â Â½Ã­Â¹â @ Area 01 https://t.co/vdqCEFjpTV
639                                                                                                                                                              Juliana Chen is brilliant beyond measure. She inspires leadership, drive, and entrepreneurialÃ¢â¬Â¦ https://t.co/AZX55qTcLr
640                                                                                                                                                                                                                                                      @douglevin hard to hack a book, huh?
641                                                                                                                                                           @bwagz54 is as good of a guy as he is an insane talent on the field for the seahawks! Thanks forÃ¢â¬Â¦ https://t.co/EjjluDsgMl
642                                                                                                                                                                                                                        Ã­Â Â½Ã­Â³Å¡ (at @UW Tower in Seattle, WA) https://t.co/JD1zT9bOgA
643                                                                                                                                                                                                                                                           A start https://t.co/r26QIPC7kE
644                                                                                                                                                                                                                                             Most humans should send emails as plain text.
645                                                                                                                                                                                                                          Ã­Â Â½Ã­Â¸â¹ @ University of Washington https://t.co/NpvV9rLmsL
646                                                                                                                                                                        This is the "well-known Capitol Hill community member" story again https://t.co/0aQtSaP0Gr https://t.co/TyaxQ2tp8A
647                                                                                                                                         @acmcnamara @newseasons My tweet might be confusing. I mean, you can still not like NS. But the grocery is part ofÃ¢â¬Â¦ https://t.co/Yek3Cvl05u
648                                                                                                                                                                                            One last 23/Union thing -- Liberty Bank Building breaks ground in June https://t.co/WC5Udf18q1
649                                                                                                                                                                                        BTW, 18k sqft @newseasons could be part of next 23/Union project completed https://t.co/enUL2qUQ94
650                                                                                                                                                    @RyanDivish Since the Ã¢â¬Åmost wins in a seasonÃ¢â¬Â thing has been done, I guess thatÃ¢â¬â¢s one way to make the record books.
651                                                                                                                                                                                                                                         Another way to look at it https://t.co/JDFOejiow3
652                                                                                                                                         Ã¢â¬ÅItÃ¢â¬â¢s an honor for us to be part of this historic partnership between our company, Forterra and Africatown." https://t.co/8rU7nyG1FI
653                                                                                                                                               $23.25M deal puts kibosh on @AfricatownSEA buying the block on its own -- community group planned to take 20% stake https://t.co/8rU7nyG1FI
654                                                                                                                                                 Seattle developer takes big risk at 23/Union where Mandatory Housing Affordability requirements being pounded out https://t.co/8rU7nyG1FI
655                                                                                                                                                                next generationÃ£â¬â¬The urbae to the green. #Ã£âÂ¸Ã£ÆâÃ£ÆÂª#green #urban @ Gas Works Park https://t.co/fdNV9QELaI
656                                                                                                                                                             This #job might be a great fit for you: Server - https://t.co/PyEMUtWwr9 #Waiter #Seattle, WA #Hiring https://t.co/rG7D4p3O16
657                                                                                                                                                           Wonderful visit to the Chihuly Studio today #Chihuly #Sandraainsleygallery @ Dale Chihuly's BoatÃ¢â¬Â¦ https://t.co/gO3xbkQy67
658                                                                                                                                          Washington. // Woof Woof Ã­Â Â½Ã­Â°Âº.\nPrayersÃ¢â¬â¹ up in and all over this place today. Prayers for everyoneÃ¢â¬Â¦ https://t.co/2B8D23nkQw
659                                                                                                                                           Listening to Chaittra Dutt CEO @Meylah  cloud architect #eCommerce expert. Teaching for @IgniteWaOrg and @SBAgovÃ¢â¬Â¦ https://t.co/1j7JsUScMn
660                                                                                                                                                                                                On the way to our fave local &amp; super fresh, hand tossed @PagliacciPizza #Ã­Â Â¼Ã­Â½â¢
661                                                                                                                                                                                                                    I'm at Apple University Village in Seattle, WA https://t.co/ogcPhuMWuU
662                                                                                                                                                                                                                   @RyanDivish whatÃ¢â¬â¢s the record for most roster moves in a season?
663                                                                                                                               When your morning run is #litAF. Ã­Â Â½Ã­Â´Â¥Ã­Â Â½Ã­Â´Â¥Ã­Â Â½Ã­Â´Â¥ Ran 4.20 miles with NikeÃ¢ÂÂ + Run Club #morningmilesÃ¢â¬Â¦ https://t.co/HAesDdBkpF
664                                                                                                                                                 A healthy spine is an active one! In addition to maintaining good posture at your desk, be sure to take breaks... https://t.co/zPZdSl7hWh
665                                                                                                                                                           Student Leadership Summit is Aug 10-12, we would love to have your group join us. Check out moreÃ¢â¬Â¦ https://t.co/mQXdfydPD6
666                                                                                                                                @yocline not saying i donÃ¢â¬â¢t support environmental and sustainability\nefforts, but the public is being lied to for tÃ¢â¬Â¦ https://t.co/7NrpXOpWLE
667                                                                                                                            @yocline totally serious. the media and AGW camp have been grossly over-exaggerating how Ã¢â¬ÅcatastrophicÃ¢â¬Â the currentÃ¢â¬Â¦ https://t.co/t5d2yoYkFZ
668                                                                                                                                                                @yocline if this is regarding climate change, thereÃ¢â¬â¢s absolutely no evidence of that beyond skewed computer models.
669                                                                                                                                                               Was stumbling around in the Herb Garden reviewing for my keying final and spotted this dude.Ã¢â¬Â¦ https://t.co/OnnoykXRrF
670                                                                                                                                           framer has always been the best prototyping tool outside of native code, looks as itÃ¢â¬â¢s about to get even better. https://t.co/3QLipLQpvq
671                                                                                                                                                                                                Quick, watch this delightfully corny video by people I work with.  https://t.co/cmAM0GixAi
672                                                                                                                                                                                   Caffeinating (and being good granddaughters!) before heading to Portland today. https://t.co/fTx2fwzTky
673                                                                                                                                                             Trying to get my consistency after the last two weeks feels like a giant mind game. However, IÃ¢â¬Â¦ https://t.co/OztxHpA03M
674                                                                                                                                                                Seattle's wind is refreshing. like "Mint wind" #mint#wind #seattle#refresh #windy#windspinsÃ¢â¬Â¦ https://t.co/XiOYLQ8iY9
675                                                                                                                                     Seattle skyline from Gas works park on a beautiful sunny spring day. #seattle #washington #usaÃ­Â Â¼Ã­Â·ÂºÃ­Â Â¼Ã­Â·Â¸Ã¢â¬Â¦ https://t.co/j8HC8k5utK
676                                                                                                                                         Apex Apartments courtyard at night! A bit of the outdoors in the center of your apartment home. 4233 7th Ave NE. AÃ¢â¬Â¦ https://t.co/zTZpUVuijP
677                                                                                                                                                                    Apex apartments has several rooms available in our large 3 bed 1.5 bath homes. $815- 841 sq ft https://t.co/WXBTwgi8eh
678                                                                                                                                                                          @lilsheba @tackyspoons you gotta think like a consultant: Ã¢â¬ÅStop doing that. ThatÃ¢â¬â¢ll be $500.Ã¢â¬Â
679                                                                                                                                                    Roommate Matching Update- Kelsey apartments has ONLY 1 Room still available. Current residents prefer male roommate- 5 bed 2 Bath $800
680                                                                                                                                              Road cleared in #Seattle on SR-520 EB after Montlake Blvd, stop and go traffic back to I-5, delay of 3 mins #traffic https://t.co/12UyGMOG9h
681                                                                                                                                               Disabled vehicle, left lane blocked in #Seattle on SR-520 EB after Montlake Blvd, stop and go traffic back to I-5, delay of 3 mins #traffic
682                                                                                                                                                                                                       Knowledge is power (@ UW: Paccar Hall - @uw in Seattle, WA) https://t.co/7pqYiHvK2r
683                                                                                                                                                Disabled vehicle, left lane blocked in #Seattle on SR-520 WB after Montlake Blvd, stop and go traffic back to Evergreen Point Floating Brg
684                                                                                                                                                                                                      Seattle, Washington - $2,775,000 USD https://t.co/rQ7K2hMRJX https://t.co/EL7QN6r5if
685                                                                                                                                                                                 Loving this darling kitchen and nook from a showing yesterday. @ Ravenna, Seattle https://t.co/Abyy4RLMfx
686                                                                                                                                                                                                     DeForest Lab @UWChemE celebrates Seattle #BikeEverywhere Day! https://t.co/XkLeEwOAHn
687                                                                                                                                                                                       I'm at University of Washington LINK Station - @soundtransit in Seattle, WA https://t.co/xHgQITVcfn
688                                                                                                                                                              Wow, last tempo run for this training cycle and it went absolutely amazing! I'm pretty pumpedÃ¢â¬Â¦ https://t.co/ycciScrK4e
689                                                                                                                                        On @UW campus for both @UWFosterSchool + @Craft3Org today, w first stop being mentor breakfast. Then @Oweesta NativÃ¢â¬Â¦ https://t.co/HYvRUJOL9O
690                                                                                                                                                                                                              slack doesnÃ¢â¬â¢t enable productivity, but turning it off certainly does.
691                                                                                                                                                     Road cleared in #WestEndOfFloatingBridge on SR-520 WB at Lk Washington Blvd, slow traffic back to Evergreen Point Rd, delay of 3 mins
692                                                                                                                                                           @mattdpearce Is this modern-day New York inhabited mostly by white walkers, aside from some other scrappy and flawed survivors?
693                                                                                                                                                             The Evans Coalition Townhall: Disrupting Systems @activemind_blog rmagika ziiives elyserickardÃ¢â¬Â¦ https://t.co/mkDJAtFM7k
694                                                                                                                                                                                         Appreciate @Ivangelina taking me out of my busy work life for someÃ¢â¬Â¦ https://t.co/ru9AkUFvlf
695                                                                                                                                                                                                               One of my favorite places in the world Ã­Â Â½Ã­Â¸Å¾ https://t.co/5e7caNyq88
696                                                                                                                                                                                          Just do the most! Ã¢ÅâÃ¯Â¸ÂÃ­Â Â½Ã­Â³Â·: @tmnlsn @ Henry Art Gallery https://t.co/cTxBiMSxR0
697                                                                                                                                                       #wallingford in bloom #happymezzo \n.\n.\n.\n.\n#sidewalk #inbloom #spring \n#Seattle #lifeontheroadÃ¢â¬Â¦ https://t.co/u9LTEE0WXo
698                                                                                                                                                              Gas Works Park #happymezzo \n.\n.\n.\n.\n#gasworkspark #gasworks #parks \n#Seattle #sculptureÃ¢â¬Â¦ https://t.co/N8Nxr85jQc
699                                                                                                                                                                                                                                 40% Off at Night Light Nail Salon https://t.co/LLIzROV6ve
700                                                                                                                                                   Thank you, #SeattleMusic @seamonster_sea @skerikmusic @musicianJD (@ SeaMonster Lounge) https://t.co/9FjwguiBCw https://t.co/NSrErSedrf
701                  Street fair  Ã­Â Â¼Ã­Â¼Â²#naan Ã¢ËËÃ¯Â¸ÂÃ¢ËËÃ¯Â¸ÂÃ­Â Â¼Ã­Â¼Â¸Ã­Â Â¼Ã­Â¼Â¸Ã­Â Â¼Ã­Â¼Â¹Ã­Â Â¼Ã­Â¼Â¹Ã­Â Â¼Ã­Â¼Â·Ã­Â Â¼Ã­Â¼Â·Ã­Â Â¼Ã­Â½â¬Ã­Â Â¼Ã­Â½â¬Ã­Â Â¼Ã­Â½â¬Ã­Â Â¼Ã­Â¼Â±spring time .#nature #TagsForLikes #sky #sun #beautifulÃ¢â¬Â¦ https://t.co/mhPmCM68qj
702                                                                                                                                                                                               @KatieHanson Sounds like a driver  got hung up in a rockery. They are securing the vehicle.
703                                                                                                                                                                  @impotentyelling @hotdogsladies I saw Star Wars at the drive-in in Idaho in 1977. And I'm pretty proud of that. I was 5.
704                                                                                                                                                                                                                           Traffic is being shutdown on 35th from 57th to 55th, all lanes.
705                                                                                                                                                                                                                                                               Correction 5556 35th ave NE
706                                                                                                                                                      Sirens are for 5565 35th Ave NE, Car went through fence and now dangling off rockery per scanner. Heavy rescue response. Car secure.
707                                                                                                                                                                                                                                      One more reason to consider moving sometime I guess.
708                                                                                                                                                                         Pretty sure the NOISE is tunnel boring. IÃ¢â¬â¢m a block away from Brooklyn, near 45th. https://t.co/EqT0L25c5B
709                                                                                                                                                                                                                                                           @bogglesnatch did you kill them
710                                                                                                                                                                                                                          @hotdogsladies What about a woman? I mean I have, but who knows!
711                                                                                                                                                                             Drinking a Monsters' Park (Tequila Barrel) by @ModernTimesBeer at @toronadon Ã¢â¬â https://t.co/gLa9QJSUV4
712                                                                                                                                                                                                                     Sailing boat #unionlake #seattle @ Lake Union https://t.co/yigCmrSdlT
713                                                                                                                                                                                                                                        WhatÃ¢â¬â¢s worse than a mushy pickle? Honestly.
714                                                                                                                                            four days to heartbreak Ã¢â¢Â¡ #breakupbench \n.\n.\n.\n.\n.\nMay 27 &amp; 28 at 2pm in Meany 267. Tickets areÃ¢â¬Â¦ https://t.co/vUERByfzzv
715                                                                                                                                                            Love these men. Brothers and now great friends. Celebrated my Dad's 69th birthday and Grandpa'sÃ¢â¬Â¦ https://t.co/XjjdjAl40G
716                                                                                                                                                                                        Congrats to my big sis for graduating with a degree in microbiologyÃ¢â¬Â¦ https://t.co/gLGDbk5wvL
717                                                                                                                                                                                                                                          Duck Dodge! @ Lake Union https://t.co/mhRmGvwFEd
718                                                                                                                                                                                            8:36pm waiting for my final client of the night. @ Caruh Salon and Spa https://t.co/hZIDmz1WW1
719                                                                                                                                                                                                                                  I'm at Duck Dodge in Seattle, WA https://t.co/OwpWO8DkqD
720                                                                                                                                                                      #thiscityhasmyheart #seattle #seattlesummer #theemeraldcity #suninseattle @ Westward Seattle https://t.co/wYbVbLzNU5
721                                                                                                                                                                                       I'm at University of Washington LINK Station - @soundtransit in Seattle, WA https://t.co/CECGZetBcx
722                                                                                                                                                                                                                 Pad Thai Heaven. Ã­Â Â½Ã­Â¸â¡ @ Kozue Restaurant https://t.co/Qa2ZHPP62q
723                                                                                                                                                                             Join me tonight for Classical Music Night at Cafe Racer in the U District of Seattle. https://t.co/EGwupkAqqS
724                                                                                                                                               Wing(s) behind the ears are always fun. #wingstattoo #behindtheeartattoo #seattle #seattletattoo #inkandpainttattoo https://t.co/V5KuLofSnv
725                                                                                                                                                             Hello, old haunts, hello and now farewell. Beneath the tree, the concrete thing, and the wall,Ã¢â¬Â¦ https://t.co/dHrcRL9oTL
726                                                                                                                                                               Apparently, date night consists of taking selfies... #lovehim #futurehusband @ Little Water Cantina https://t.co/bHtvuV4Jbf
727                                                                                                                                                                                                                                 Husky! #UW @ Husky Union Building https://t.co/YIkRJFj7LY
728                                                                                                                                                                                                                                 Husky! #UW @ Husky Union Building https://t.co/mOulAoSDNw
729                                                                                                                                                                             It's the water. Ã­Â Â¼Ã­Â½ÂºÃ­Â Â¾Ã­Â¶â  #duckdodge #seattle #lakeunion @ Lake Union https://t.co/02u9XYoOUi
730                                                                                                                                                                                                       ItÃ¢â¬â¢s believable! ThatÃ¢â¬â¢s what I like about it. https://t.co/7Sgh1RyNAn
731                                                                                                                                                                                                               @MattDownsDraws Sparkster would woup him, just sayinÃ¢â¬â¢. Ã­Â Â½Ã­Â¸â°
732                                                                                                                                                                      Lo, a gift from the universe! #athing #afoundthing #foundfortune #notactuallyafortuneÃ¢â¬Â¦ https://t.co/uNqgGLfhsa
733                                                                                                                                              I just started using @ridewithgps, seems super promising! Killer data for cyclists of all sorts, not just carbon fiber ridin' athletic tanks
734                                                                                                                    Balance. Ã­Â Â½Ã­ÂºÂ´Ã­Â Â¼Ã­Â¿Â¿Ã­Â Â½Ã­ÂºÂ´Ã­Â Â¼Ã­Â¿Â¿Ã­Â Â½Ã­ÂºÂ´Ã­Â Â¼Ã­Â¿Â¿Ã­Â Â½Ã­ÂºÂ´Ã­Â Â¼Ã­Â¿Â¿ #bikeride @ University of Washington https://t.co/hYBxbQPV4w
735                                                                                                                                                 Sneak peak! #phra is magical Ã­Â Â¾Ã­Â¶â We are releasing these at our Stand Up For Harm Reduction eventÃ¢â¬Â¦ https://t.co/piFEQrxwQt
736                                                                                                                                                                                          Row, row, row your boats Ã­Â Â½Ã­ÂºÂ£Ã­Â Â¼Ã­Â¿Â» #lastyear @ Lake Union https://t.co/mEweb2zwzI
737                                                                                                                                                             All good things must come to an end. Working with you guys was the most amazing experience andÃ¢â¬Â¦ https://t.co/1L722YNCbW
738                                                                                                                                                                              I could've posted the good photos, but these were even better ÃÂ¯\\_(Ã£Æâ)_/ÃÂ¯ https://t.co/GBzNDSa9wt
739                                                                                                                                                                                                                     Big Little pairs!! @ University of Washington https://t.co/h0DrToGwFU
740                                                                                                                                                             @lilsheba @heyrobbyj @michaeljmaddux I got Ã¢â¬ÅRob Johnson.Ã¢â¬Â \n\nI think this thing might be broken.\n\nÃ­Â Â½Ã­Â¸Â
741                                                                                                                                                       Always too soon, #Seattle. Thanks for the clear view of #MtRainier &amp; the #sunshine...you make itÃ¢â¬Â¦ https://t.co/I1VTEk3Adf
742                                                                                                                                                        Anyone tried a #Jamboard? Very curious to hear if it's any better than the status quo interactive options. https://t.co/m2jdarz3ec
743                                                                                                                     The Ã¢Ëâ¬Ã¯Â¸Â is finally out and we're optimistic.Ã­Â Â½Ã­Â¹ÅÃ­Â Â¼Ã­Â¿Â» Join us for our Summer Kick-offÃ¢â¬Â¢Sweat &amp; StyleÃ¢â¬Â¦ https://t.co/MEDhDINKDf
744                                                                                                                                                                                          Today I'm working at... @ Northeast Branch of The Seattle Public Library https://t.co/6ang2LIgLt
745                                                                                                                                                                                       Sunset dinner hangs. #seattle #friends #friendcation @ Little Water Cantina https://t.co/BdY39L20Mm
746                                                                                                                                                                                                                    Looking good SeattleÃ¢Ëâ¬Ã¯Â¸Â @ Lake Union https://t.co/UGJEen4YF9
747                                                                                                                                                                                 Enter to win a DVD copy of "Get Out" at Recess. #getout #getoutchallenge @ Recess https://t.co/MujfIK0OdN
748                                                                                                                                                                                                                                    Putting @RobotEMAR v3 together https://t.co/yeGfsSAipZ
749                                                                                                                                                                                           INR &amp; Thyroid check Ã­Â Â½Ã­Â±Â (@ UWMC Blood Draw in Seattle, WA) https://t.co/1zFYU3W8Ll
750                                                                                                                                               (Day 143) 5/23/17: The Spanish Fly breakfast sammie from morselseattle Ã­Â Â½Ã­Â¸â¹ SO GOOD! #seattle #foodÃ¢â¬Â¦ https://t.co/4i8Qf2tqFO
751                                                                                                                                                                   DidnÃ¢â¬â¢t he fuck this up the exact same way as Huckabee? How hard is it to spell CNN bros? https://t.co/BB9UfsdbXX
752                                                                                                                                                                                                                                   Ã¢â¬ÅHot take: some very popular thing is bad!Ã¢â¬Â
753                                                                                                                                                                                         seattle! #Ã£âÂ·Ã£âÂ¢Ã£ÆËÃ£ÆÂ«#vacation @ Washington Park Arboretum https://t.co/N86CzPFrZB
754                                                                                                                                              Ã­Â Â½Ã­Â±Â¸Ã­Â Â¼Ã­Â¿Â»#bytheweifashion: I am gong to miss this magical spot a lot after moving to New York.Ã¢â¬Â¦ https://t.co/P9gDcfK4dP
755                                                                                                                                                                                                                                               @ryanmerkley you Canadians are just so cute
756                                                                                                                                                                                               Happy Tuesday! @grasshopperhub @morgana2020 Lake Union @ Lake Union https://t.co/Y8hnP4NSxm
757                                                                                                                                                                          Team SBTN has been busy planning a Memorial Day Sale Event this Thursday, 5/25 atÃ¢â¬Â¦ https://t.co/hPS2UK14Kb
758                                                                                                                                                                                                                 Just posted a photo @ Volunteer Park Conservatory https://t.co/ODedsISuMO
759                                                                                                                                                                  We're open until 7pm tonight!!! PRE-SUMMER  SALE IS LIVE!!!! May 18th-25th. \n10% OFF ALLÃ¢â¬Â¦ https://t.co/YIhUETrcaf
760                                                                                                                                                                                        Lovely evening last night with friends! #ivarssalmonhouse @ Gas Works Park https://t.co/MNmtWpjztC
761                                                                                                                      We've got two new pansies in, &amp; they're looking for a home!! Ã­Â Â½Ã­Â¸â°\n#flowers #seattle\n-- --\nPansy 'Frizzle Sizzle Blue'Ã¢â¬Â¦ https://t.co/lWC0RmHIWQ
762                                                                                                                                                                                                            I have the best colleagues. @ University of Washington https://t.co/BvoL6ZywvB
763                                                                                                                                                                Had #microblading done on brows by the talented mrshoots before and after!swipe left to seeÃ¢â¬Â¦ https://t.co/g74YUjyqL9
764                                                                                                                                                                                                                                                                 Shine season Ã­Â Â¼Ã­Â¼Â¤
765                                                                                                                                                                          Sometimes you just have to make silly faces on a nice day Ã­Â Â½Ã­Â¸Å @ Bertschi School https://t.co/SyP4UNNVRv
766                                                                                                                                                                                                                                                                  @ToddLa @ACLU_WA Agreed!
767                                                                                                                                                                                                                         Sunshine yields new patterns to the east. https://t.co/ikq2HF8vmG
768                                                                                                                                     @ACLU_WA Tellingly, highlighted iPhone is a 5C. Current gen. iPhones have "Secure Enclave" &amp; are better protected.Ã¢â¬Â¦ https://t.co/30G4Re8Zbj
769                                                                                                                                                                                       Ã­Â Â¼Ã­Â¾Â¶Ã­Â Â¼Ã­Â¾Â¶Ã­Â Â¼Ã­Â¾Â¶YOU CAN'T STEAL MY THUNDER Ã­Â Â¼Ã­Â¾Â¶Ã­Â Â¼Ã­Â¾Â¶Ã­Â Â¼Ã­Â¾Â¶
770                                                                                                                                                                      The wait is over... EcoPots have been restocked!! Ã­Â Â½Ã­Â¹ÅÃ­Â Â½Ã­Â¹Å #pottery #seattle https://t.co/MjxLDD66d0
771                                                                                                                                                               regrann from bizxnow  -  At @heartbeetosc in Seattle, the power of natural food and juice isÃ¢â¬Â¦ https://t.co/lQ7BoR8Wyu
772                                                                                                                                     @grossguano Group booth + Ã¢â¬ÅIÃ¢â¬â¢ll be here on sat/sun, my buddies can take $ for my stuff until thenÃ¢â¬Â sign MIGht help some butÃ¢â¬Â¦
773                                                                                                                                                   @grossguano seriously, i mean like if I was gonna work BLFC I might take some badges on thursday butÃ¢â¬Â¦ normal comic cons? Fuck it.
774                                                                                                                                                           We now have 3 flavors of kombuchatown #kombucha #atthehenry #udub #universityofwashington @ CityÃ¢â¬Â¦ https://t.co/Qyh7OMcjdA
775                                                                                                                                                                               I'm certain many an opera singer has passed through these doors. @ Portage Bay Cafe https://t.co/z8uUTwgngo
776                                                                                                                                                                                       Somebody dropped their drawers right on the sidewalk @ Wallingford, Seattle https://t.co/I2JHo2KnWh
777                                                                                                                                                                Sing it, Alice!  #realfoodthatlovesyouback  #heartbeetosc #veganseattle @ HeartBeet OrganicÃ¢â¬Â¦ https://t.co/2SebyvW24Q
778                                                                                                                                                    Road cleared in #Seattle on I-5 SB at E Roanoke St, slow traffic back to NE 185th St, delay of 8 mins #traffic https://t.co/12UyGMOG9h
779                                                                                                                                                                                              @steinekin @nickytwit ROFL. ThatÃ¢â¬â¢s the least inappropriate thing hiding in the photo.
780                                                                                                                                               Ramp restrictions in #Seattle on I-5 SB at E Roanoke St, slow traffic back to NE 185th St, delay of 8 mins #traffic https://t.co/12UyGMOG9h
781                                                                                                                                                        VariousFoods.png\n.\n.\n.\n. \n. \n#seattle #food #sushi #kimchi #cutie #bluecsushi #hmart @ Blue CÃ¢â¬Â¦ https://t.co/laS3LC1N0o
782                                                                                                                                                             Accident, left lane blocked in #Seattle on I-5 SB at 45th St, stop and go traffic back to 236th St, delay of 26 mins #traffic
783                                                                                                                                                                   The best thing about a height adjustable desk is how much easier it is to dance while you work. https://t.co/PhqJRXtEa1
784                                                                                                                                                             Just another backflip Monday! #backflip fun day dillonjohndean and sanderlingphotography @ GasÃ¢â¬Â¦ https://t.co/bM2zwpH4ev
785                                                                                                                                                      It's this little bean's birthday Ã­Â Â½Ã­Â²â¢ love you five ever and ever nugget @ University of Washington https://t.co/kakb7dyAPQ
786                                                                                                                                                                                                     Stay tuned for some awesome pictures! W/ psevill @ Lake Union https://t.co/yg3dvqmQry
787                                                                                                                                                                                                                              wholesome jack in the box experience https://t.co/khBYIAzFBf
788                                                                                                                                                                                     @lentilstew [breathy southern belle voice] your honorÃ¢â¬Â¦ I pleadÃ¢â¬Â¦. Ã¢â¬Ånot guiltyÃ¢â¬Â
789                                                                                                                                                  Bonus: pictures too cute not to post from our last chapter meeting of the academic year!Ã­Â Â½Ã­Â²Å haveÃ¢â¬Â¦ https://t.co/tgxJ2GUjob
790                                                                                                                                                            And congratulations to our awesome graduating seniors!! Please don't leave us, we're gonna missÃ¢â¬Â¦ https://t.co/vwMMQjW0zc
791                                                                                                                                                                Welcome to the Zeta Sigma family, Lambda class! Ã­Â Â½Ã­Â²Å #induction @ University of Washington https://t.co/d8MxKnmJ1h
792                                                                                                      Ã­Â Â½Ã­Â±Â¸Ã­Â Â¼Ã­Â¿Â»#bytheweifashion: How to style a chic summerÃ¢Å¡Â¾Ã¯Â¸Âcap? Check @elcocoapapi Ã­Â Â¼Ã­Â¾ËUse my codeÃ¢ÅÂ¨BTWENDYÃ¢ÅÂ¨forÃ¢â¬Â¦ https://t.co/QSRzeVOhHT
793                                                                                                                                                                                     Funny little #curved #clouds over #lakeunion #sunset #lamourita @ L'Amourita! https://t.co/kXC3KZFogd
794                                                                                                                                                            Accurate description of our friendship in the form of a capturable moment provided by the folksÃ¢â¬Â¦ https://t.co/NxNBupRElr
795                                                                                                                                                                    Westy's just what Roosevelt need sports bar, Chicken n Waffles and skeeball @ Pies &amp; Pints https://t.co/fWlRt4XFvi
796                                                                                                                                                                                         Just made it to poke before they closed @ 45th Stop N Shop &amp; Poke Bar https://t.co/BbTsG3JzOk
797                                                                                                                                                                                                            Fav pupper came to play today Ã­Â Â½Ã­Â¸ÂÃ­Â Â½Ã­Â¸Â­ https://t.co/mu3wmQ17YT
798                                                                                                                                                       I love sun. And the sun loves me. Twaddle a dee, dee dum, dee dee dee Ã­Â Â¼Ã­Â¾Â¶ #summer @ SeattleÃ¢â¬Â¦ https://t.co/D2k2nZsIlW
799                                                                                                                                                                                                             A great meal spontaneously planned @ Joule Restaurant https://t.co/cK16CtiKKv
800                                                                                                                                                                                                  Dear Seattle,\nMy heart is full Ã­Â Â½Ã­Â²Å¡ .  #gratefulÃ¢â¬Â¦ https://t.co/N0JjS14t7z
801                                                                                                                                                             These sixteen kids conquered the unknown in WA state #acappella. Cheers to this groundbreakingÃ¢â¬Â¦ https://t.co/0CVqmpifYm
802                                                                                                                                                           Checking out the University District in Seattle.  Such a nice little part of town, reminds me ofÃ¢â¬Â¦ https://t.co/WyZR3tHy8t
803                                                                                                                                                        delicious @DeLILLECELLARS wine, scrumptious food, fabulous location, and gorgeous weather. #livingthedream https://t.co/7qTV7QIycG
804                                                                                                                                                                                   Ã­Â Â½Ã­Â»Â©Ã¯Â¸ÂÃ­Â Â½Ã­Â»Â©Ã¯Â¸ÂÃ­Â Â½Ã­Â»Â©Ã¯Â¸Â #bucketlist @ Lake Union https://t.co/O6Qk9swBLn
805                                                                                                                                                                                   @SkotterAD YouÃ¢â¬â¢d be welcome to tag along with my crew any time. Hope you still decide to come :3
806                                                                                                                                                                                                      Stripes - Brooke Eva\n#mamiya645 #cinestillfilm @ Park Vista https://t.co/ZXZhEW8fk2
807                                                                                                                                                                                                                       @witch_boy aww geeze, IÃ¢â¬â¢m sorry to hear that. My sympathies.
808                                                                                                                                                             @LuDux @VancouverComics especially when you sell the last one in the last hour of the con. ThatÃ¢â¬â¢s WINNING right there.
809                                                                                                                                                               John from teamsecurite and buduracing is like the office Santa clause. Everyone few weeks heÃ¢â¬Â¦ https://t.co/bXRBmuGg0g
810                                                                                                                                                                       Drinking a Ziggy Zoggy Summer Lager by @silvercitybrew @ A-Pizza Mart North Ã¢â¬â https://t.co/JzGdyxwDyl #photo
811                                                                                                                                                                            Thank you to @VancouverComics for a lovely time! I went with 20 copies of Decrypting Rita and returned with 0.
812                                                                                                                                                                                                                                                                     @OkazuYuri Thank you!
813                                                                                                                                         Non-obituary how Roger Ailes exploited the Monica Lewinsky story to benefit Fox News Ã¢â¬â written by: Monica Lewinsky https://t.co/cfvWhnXrPP
814                                                                                                                                                                                           @PMaka1991 @Rainbow6Game @UbiWorkshop Damn, I want one bad, but I have a million black hoodies.
815                                                                                                                                                                                                                                              Critical typesetting https://t.co/7LaTJfSU6I
816                                                                                                                                                                          Awesome Food!\n\n#seattle #japanesefood #ramen #ramennoodles #softboiledeggs @ RAMEN MAN https://t.co/oeHndRv9X9
817                                                                                                       Ã­Â Â½Ã­Â±Â¸Ã­Â Â¼Ã­Â¿Â»#bytheweifashion: Looking for a chic summerÃ¢Å¡Â¾Ã¯Â¸Âcap? Check @elcocoapapi Ã­Â Â¼Ã­Â¾ËUse my codeÃ¢ÅÂ¨BTWENDYÃ¢ÅÂ¨forÃ¢â¬Â¦ https://t.co/gFofS1k0B6
818                                                                                                                                                                      Ã¢ÅÅÃ­Â Â¼Ã­Â¿Â½Ã¢ÂÂ¤Ã¯Â¸Â #ClockThatConstruct Ã­Â Â½Ã­Â³Â·: @tmnlsn @ Henry Art Gallery https://t.co/a04p53FbJB
819                                                                                                                                                                         @BAKKOOONN This is one of the best things IÃ¢â¬â¢ve gotten out of following you, and thatÃ¢â¬â¢s saying a lot
820                                                                                                                                        Lost out on a 2 bedroom apt for Fall? Next best thing is here! Entire lower floor of Apex apartment!!! FULLY RenovaÃ¢â¬Â¦ https://t.co/c6iTQeNwLo
821                                                                                                                                                                                                       Trump to Israelis: "We just got back from the Middle East." https://t.co/3CS2AUeMFk
822                                                                                                                                                            Inspiration for my new dress collection #1973 #frenchfashion #lisavianhunter #fullfiguredressesÃ¢â¬Â¦ https://t.co/F2reaN5bgT
823                                                                                                                                                                                                Rollin' with my boy! #frankygoestohollywood @ Wallingford, Seattle https://t.co/E6MhgxY06X
824                                                                                                                                                                      @BrettHamil @SCC_Insight First interview down. Her answers: hell yes, needs to "start over," needs to be scaled back
825                                                                                                                                                                                                             Spring Show 2017: @bigbabydram @ Husky Union Building https://t.co/r0McUzQ7ZG
826                                                                                                                                                                                                                                         "La Croix drink specials" https://t.co/olYMqVazP7
827                                                                                                                                                                              He did that last time. This time he wants to speed light rail construction. I think. https://t.co/tegqctNVXZ
828                                                                                                                                                                                                      Ducks and a heron while on a walk @ Seattle Asian Art Museum https://t.co/Fmu6Mpyd8V
829                                                                                                                                                          PRE-SUMMER  SALE IS LIVE!!!! May 18th-25th. \n10% OFF ALL CONSIGNMENT ITEMS INCLUDING SHOES.  30%Ã¢â¬Â¦ https://t.co/Uy4Q1LtT5s
830                                                                                                                                                                Can't believe my baby boy turned 21!  Thank you April, daneonaga, jahngsta  for making it aÃ¢â¬Â¦ https://t.co/p76YETAd06
831                                                                                                                                                                        Poignant times at The Black Hole Sun, inspiration for the Soundgarden song #SeattleÃ¢â¬Â¦ https://t.co/QyBlvHdRSu
832                                                                                                                                                                         First time back at the gym for a while. 9.5 miles and 1650 calories on the machines alone. Progress! #56lbs56days
833                                                                                                                                         @skroyboy Oops? More like Congratulations! You have unlocked the real world sideways trapdoor to the secret #QbertÃ¢â¬Â¦ https://t.co/J5hujnIOdT
834                                                                                                                                                               Just found out I'm shooting a Fall Elopement at the Arboretum in October, can't wait. I loveÃ¢â¬Â¦ https://t.co/llqcNBwVqk
835                                                                                                                                                                      Lazy days at the park with my favorite boys. @thelongsession #TripawdLove #doggydaddyÃ¢â¬Â¦ https://t.co/U4dG92VUCp
836                                                                                                                                                                                                       Excuse me while I use your dorm study lounge to take a call https://t.co/QEAIKRXvQl
837                                                                                                                                                                                                                   More, faster transit. More, denser development. https://t.co/qQV47UJfCr
838                                                                                                                                                                                                          #sdot weekday does this sign even mean? @ 14 Carrot Cafe https://t.co/526XysafqP
839                                                                                                                                                       @ErikLundegaard Here's some more info from almost a month ago: https://t.co/UtsB9IXiUI Equity firm running a little low on equity?!
840                                                                                                                                                                                                        @BrettHamil @SCC_Insight I can do that in one question. "Is your name Nikkita?" :)
841                                                                                                                                                                                                                                @mattsteno I was hoping to not get into capital punishment
842                                                                                                                                                                                                                Capitol Hill Community Post | Some FoodArtÃÂ News https://t.co/cabOt9Jqvj
843                                                                                                                                                                                                                          @joshc obvious starter. but maybe be sneaky and save it for last
844                                                                                                                                                                                                                                    Mmmmmm,....gritty space donut. https://t.co/CwvxsSXJOw
845                                                                                                                                                Somebody make an Ultimate GaramondÃ¢âÂ¢ including alternates that cover essential styles from Garamont to Rosart https://t.co/0rZH0z5aQi
846                                                                                                                                                     awful news, @NickyHayden passed away today after his serious cycling crash last week: https://t.co/yERT2Btxbs https://t.co/8w3Suu0QFp
847                                                                                                                                                      Nice. New paint job and cleanup at Broadway's New India Express... and they're applying for a liquor license https://t.co/FXakTrpGBW
848                                                                                                                                                                                                                                      @pcgamer where is the Davenport hot take on this????
849                                                                                                                                                regrann from @rubyremedies  -  What a beautiful day for a picnic at Greenlake Ã¢â¬Â¼Ã¯Â¸Â With my bestie,Ã¢â¬Â¦ https://t.co/LHOZvUEiCr
850                                                                                                                                                               regrann from justthewayiyam  -  First meal in Seattle did not disappoint!!! #realfood #saladÃ¢â¬Â¦ https://t.co/wlhwP8jczZ
851                                                                                                                                                                                                          .@berkun do you know the sex of that salmon?  https://t.co/3LpW5shHM5 #ignitesea
852                                                                                                                                                   (Day 141) 5/21/17: @hillynakz's first time out and about on the ground. Little puppersÃ­Â Â½Ã­Â°Â¶ + bigÃ¢â¬Â¦ https://t.co/UUauljHehF
853                                                                                                                                                                   .@JayminSpeaks @Eri_Kardos demonstrate how to deliver a baby by themselves - https://t.co/VzCDmDWlKZ from @ignitesea 33
854                                                                                                                                                                                    Seattle, we're here to fuel the best version of you!  #heartbeethealthyÃ¢â¬Â¦ https://t.co/F5IJpSqc1Y
855                                                                                                                                                                                                                                                      This is from my Instagram story, btw
856                                                                                                                                                                                         My pix from last weekÃ¢â¬â¢s @ignitesea event - https://t.co/uSVtWPxj5B https://t.co/8OMrNv5fKm
857                                                                                                                                                                                                                                                              fact https://t.co/nMBuzNbCMv
858                                                                                                                                      Got to experience being a judge last night at University of Washington's Miss Greek pageant!Ã­Â Â½Ã­Â²ÅÃ­Â Â½Ã­Â²âºÃ¢â¬Â¦ https://t.co/UFWM4yAIIY
859                                                                                                                                                                                                                   @legendaryjoeb sorta- haven't seen the new show but love the characters
860                                                                                                                                                                                                                 @MrNickMcSpadden @Contains_ENG @thejedi NOW youÃ¢â¬â¢re talkinÃ¢â¬â¢.
861                                                                                                                                                                                                                                     Ã¢Ëâ¢Ã¯Â¸Â @ Cafe Solstice https://t.co/pjyydNVveP
862                                                                                                                                                                                     Fantasizing about camping in the woods with a bunch of sweaty boys and being horny animals together ~
863                                                                                                                                                          #sunset over #lakeunion #happymezzo\n.\n.\n.\n#lakeunionseattle #gasworks #gasworkspark #explorerÃ¢â¬Â¦ https://t.co/cPkSpEsAnc
864                                                                                                                                                                                                    Brewery "Take the Pint" Night with Reuben's Brews at Toronado  https://t.co/QeoSJD9L8S
865                                                                                                                                                                                                                                                      fuck google. https://t.co/la5PY5c746
866                                                                                                                                                             So this happened... || #summercut #longhairgonewhere #muchhandsome shelbyatderby @ Derby SalonÃ¢â¬Â¦ https://t.co/a4wWWWtYrL
867                                                                                                                                 @asrielpls @BayerShep IÃ¢â¬â¢m glad I amuse you! Collies like digging holes :P Pathetic, hilarious holes. *Wondering howÃ¢â¬Â¦ https://t.co/ye3moRIg4H
868                                                                                                                                 @BayerShep @asrielpls Ignore your friendÃ¢â¬â¢s immaturity. And ad hominem condescending attacks provoking me. Seems aboÃ¢â¬Â¦ https://t.co/GB4U6IgLcR
869                                                                                                                                                                                                                 Just posted a photo @ Volunteer Park Conservatory https://t.co/Jc5N2mbWb6
870                                                                                                                                 @KenningDog @OronaRed No, because itÃ¢â¬â¢s getting retweeted and interpreted in the way I interpreted it, and I think iÃ¢â¬Â¦ https://t.co/16nPIdN2J5
871                                                                                                                                        @asrielpls @BayerShep Are you having fun mocking me? Lol. You seem to be of the opinion I give a flying fuck what yÃ¢â¬Â¦ https://t.co/T52bEtiRfy
872                                                                                                                                                                                                                                                     This place is a shit show tonight #ER
873                                                                                                                           @TheScotchDonk He is, and yes, assuming heÃ¢â¬â¢s taking his meds and has an undetectable load, it is accurate. DoesnÃ¢â¬â¢tÃ¢â¬Â¦ https://t.co/DWfGFAYMnA
874                                                                                                                                 @BayerShep IÃ¢â¬â¢ve not engaged in anything less professional than your counterproductive scare tactics :P But apply asÃ¢â¬Â¦ https://t.co/gJkdjG2bOp
875                                                                                                                                              @BayerShep ItÃ¢â¬â¢s just as careless not to ask status before engaging in bareback sex. And, yes, you are shaming a class of individuals.
876                                                                                                                          @BayerShep IÃ¢â¬â¢m not putting my faith in anyone. IÃ¢â¬â¢m on PrEP and use condoms with non-trusted friends/long-term partnÃ¢â¬Â¦ https://t.co/1YEnwhXtze
877                                                                                                                    @BayerShep I wouldnÃ¢â¬â¢t eitherÃ¢â¬Â¦ so ask status first, and if you arenÃ¢â¬â¢t comfortable, use a rubber or donÃ¢â¬â¢t fuck. Not a big issue. Communicate.
878                                                                                                                                          Arboretum, Washington park, Portland #portland #oregon #usaÃ­Â Â¼Ã­Â·ÂºÃ­Â Â¼Ã­Â·Â¸ #worldtravel #nature #flowersÃ¢â¬Â¦ https://t.co/7WMcLbYf5G
879                                                                                                                                        @PaladinWulfie @TykeBraxeAD @asrielpls I am not defending everything the guy said, it was a shitty exchange. I justÃ¢â¬Â¦ https://t.co/lgPBLvzXp2
880                                                                                                                                 @PaladinWulfie @TykeBraxeAD @asrielpls No one is arguing that disclosure shouldnÃ¢â¬â¢t happen. A witch hunt towards somÃ¢â¬Â¦ https://t.co/UkGMwsJJwP
881                                                                                                                                                  Gentle chiropractic treatments have shown to be beneficial for growing children. If you have a young child at... https://t.co/W9m5e9Prwn
882                                                                                                                                 @PaladinWulfie @TykeBraxeAD @asrielpls ThatÃ¢â¬â¢s true on the population level but is not likely true on the person levÃ¢â¬Â¦ https://t.co/NSNbvMzgsx
883                                                                                                                                         Took some photos of Iris Kymm and Parenthesis earlier today. Never took singers photos in natural lighting before.Ã¢â¬Â¦ https://t.co/QhX00LYusm
884                                                                                                                                                                        Type 2 fun to make type 1 into type none. Love being apart of #TeamJT every year toÃ¢â¬Â¦ https://t.co/vvXLA1KwBK
885                                                                                                                                                                                                                Some highlights of 2 days eventÃ¢ÂÂ¤Ã­Â Â½Ã­Â¸â¡ https://t.co/g18W6DX3zx
886                                                                                                                                                                                                  @isabella_wong_ Not sure if intended, but site is not accessible https://t.co/u31uq2KY2d
887                                                                                                                                                                                                                                        #inmemory @ Volunteer Park https://t.co/b1xYE8T8oP
888                                                                                                                                                                                                                                                         @asrielpls @TykeBraxeAD Fuck you.
889                                                                                                                                  @asrielpls @TykeBraxeAD Learn how to scroll. I already made my point. IÃ¢â¬â¢m not looking to fight you if that is yourÃ¢â¬Â¦ https://t.co/R6jsP86ZfO
890                                                                                                                                                  @asrielpls @TykeBraxeAD Nothing to do with feelings, but like I said, we donÃ¢â¬â¢t need to agree. IÃ¢â¬â¢m not here to impress you.
891                                                                                                                                         Dinner tonite @ @JuneBabySeattle was fantastic. Favorites = roasted carrots w/ collard greens, sweet potato cookieÃ¢â¬Â¦ https://t.co/nOMDabG83l
892                                                                                                                                                                                                                                                  @Bairaisu Absolutely! No argument there.
893                                                                                                                                                                What fresh hell is this? This is considered acceptable behavior by a comedy venue? @ LaughsÃ¢â¬Â¦ https://t.co/vcRpRd4HJn
894                                                                                                                                                                Beat the Bridge 2017.\nMany don't know that type 1 is even more than high/low blood sugars,Ã¢â¬Â¦ https://t.co/RCaOjGuioD
895                                                                                                                                                                After Nate and I strolled around the University District Street Fair, we went to the VeggieÃ¢â¬Â¦ https://t.co/EXzfGvOhWa
896                                                                                                                                                                                                              where they grow the beer @ Shultzy's Bar &amp; Grill https://t.co/i4geOUCS5H
897                                                                                                                                                               The grass is always green here in Seattle but when the weather is nice it's even more green.Ã¢â¬Â¦ https://t.co/3fadyzkHwf
898                                                                                                                                                                   Another shot of Gas Works. #pnwonderland #cruise #pacificnorthwest #seattlelife #seattleÃ¢â¬Â¦ https://t.co/1NtWTUbxnL
899                                  U district farmers market Ã¢ËËÃ¯Â¸Â Ã­Â Â¼Ã­Â¼Â¸Ã­Â Â¼Ã­Â¼Â¸Ã­Â Â¼Ã­Â¼Â¹Ã­Â Â¼Ã­Â¼Â¹Ã­Â Â¼Ã­Â¼Â·Ã­Â Â¼Ã­Â¼Â·Ã­Â Â¼Ã­Â½â¬Ã­Â Â¼Ã­Â½â¬Ã­Â Â¼Ã­Â½â¬Ã­Â Â¼Ã­Â¼Â±spring time .#nature #TagsForLikes #sky #sun #beautifulÃ¢â¬Â¦ https://t.co/vldnNfEg7X
900                                                                                                                                                                                                                  Visit to the temple @ Dick's Drive In Restaurant https://t.co/IeVEBnMzks
901                                                                                                                                                                                                I'm at Molly Moon's Homemade Ice Cream - @mollymoon in Seattle, WA https://t.co/lALPXe0cgA
902                                                                                                                                                                We're so happy to be part of the Seattle and surrounding community. Beautiful, warm #springÃ¢â¬Â¦ https://t.co/MZXV5bmyfo
903                                                                                                                                                                How the %^*# did I go eleven years in Seattle without going to the Japanese Gardens? So beautiful! https://t.co/QRRUucm8LP
904                                                                                                                                                                                                                        #rip Chris Cornell @ Black Sun (sculpture) https://t.co/7yI1M5moGK
905                                                                                                                                                                                                                             "Did you take adderall today?"\n"No! I'm just Tim!!" @timabot
906                                                                                                                                                                                                                                    That face! #destress #dogs #UW https://t.co/pMcAF9s0kD
907                                                                                                                                                                                                                                    We're hiring!  Check itÃ¢â¬Â¦ https://t.co/UverJr3Mgn
908                                                                                                                                                               Dreamy days @vpconservatory ... I love this perspective of the Conservatory. Reminds me of aÃ¢â¬Â¦ https://t.co/VluBPlc8Th
909                                                                                                                                                   Door's open! It was...they tell me...uncharacteristically sunny Ã¢Ëâ¬Ã¯Â¸Â for Seattle, so I made theÃ¢â¬Â¦ https://t.co/Pz4ZwGhrRP
910                                                                                                                                                                                                                                                             @emccoy_writer Three hundred.
911                                                                                                                                                                            Shoutout to the guy who brought his fidget spinner to @iamblackbear concert last night https://t.co/SzT3ruESzx
912                                                                                                                                                            That amazing moment when the other team passes an overfeed and you bop it straight down for theÃ¢â¬Â¦ https://t.co/hVhOK7sSEw
913                                                                                                                                                           Ruby, red, vermillion, burgundy, cardinal, scarlet, crimson, carmine... just a few of the shadesÃ¢â¬Â¦ https://t.co/BQlkHojsVE
914                                                                                                                                                              #MonsteraMonday on this Memorial Day from @vpconservatory Ã­Â Â½Ã­Â²Å¡ @ Volunteer Park Conservatory https://t.co/kb4tzWcK9X
915                                                                                                                                  @dubsteppenwolf @SatanaKennedy went googling for Jane Chotard and the event page was one of the few hits, andÃ¢â¬Â¦ damnÃ¢â¬Â¦ https://t.co/psrRzE20tP
916                                                                                                                                                         2 years ago!! Time flys.\n\nThe Day I remember to forget the Most. \n\nGlad I ain't laying in thatÃ¢â¬Â¦ https://t.co/nx2sstzBPo
917                                                                                                                                                                                                                                      Well this is fun. OKC bound. https://t.co/htCMENkYUt
918                                                                                                                                                               90 on the #top100 burgers in America: the single with grilled onions @GreatStateSEA. Also, IÃ¢â¬Â¦ https://t.co/JGB1ekNpxR
919                                                                                                                                                                   @uwsoftball You know what it is!!! #superregionals #turnuptime #pac12 #softball #godawgsÃ¢â¬Â¦ https://t.co/3RuKBNzJTK
920                                                                                                                                                     Great, long day at #TEDxUW. Hung out w/students. Made new friends. Started critical convos. #BeABridgeÃ¢â¬Â¦ https://t.co/M9V1o542sJ
921                                                                                                                                                                             Game three of Utah vs UW. Winner advances to the College World Series. @desnewssports https://t.co/OiNCAf8y7x
922                                                                                                                                                                                                              forever reading; forever creating; @ Neptune Theatre https://t.co/zKSwTD5u7B
923                                                                                                                                               3/? A moment to reflect on the destruction of ramps to a freeway the people fought and successfully stopped.Ã¢â¬Â¦ https://t.co/A0dYWo3Es9
924                                                                                                                                                         ***Key Learning Alert *** "If you are human, you're biased. We are all biased." @SMDiversity  #TedxYesAnd https://t.co/td2JbShxXW
925                                                                                                                                                       Land heron, tree heron. Ã­Â Â½Ã­Â¸Â² #iphone7plus #seattle #summer #nofilter @ University District, Seattle https://t.co/1E5dCwIjsA
926                                                                                                                                                                You can still walk up and restart to ride #EmeraldBikeRide until 7:45am. Look what you're missing! https://t.co/0lZqpvyk6q
927                                                                                                                                                                                    I don't know who's boat this is, but I know we should be friends. @ Lake Union https://t.co/HcXM42fUqd
928                                                                                                                                        RT @uncle_vinny: "Ever had a breast cancer survivor cry in your office worried that she caused her cancer by wearing bras for 20 yrs? ProbaÃ¢â¬Â¦
929                                                                                                                                        Prepping for 2nd #TEDx 2moro at #UW. Part of program called "Yes, and..." I'm talking abt storytelling as bridge-blÃ¢â¬Â¦ https://t.co/7qVJTuekfS
930                                                                                                                                                                                                                             houseboat weekend! come by and hang ! https://t.co/dGhvXiYIPo
931                                                                                                                                                               The #WOF8 squad!! @skatelikeagirl @atskatepark @evogear Ã­Â Â½Ã­Â³Â·: @mahfia_tv @mahfiabossÃ¢â¬Â¦ https://t.co/pCqz4QsCPc
932                                                                                                                                                             I could not be more proud of the middle sister for obtaining the MD today! I realize that manyÃ¢â¬Â¦ https://t.co/TLKNJCd5mx
933                                                                                                                                             @NaqRyba @The_PoolParty @Rukario71 Ã¢â¢Â©HAM hit the flo\nNext thing you know\nSIBER got low low low low, low low low NOSEÃ¢â¢Â© :O3 ~C&gt;
934                                                                                                                                        @NaqRyba @The_PoolParty @Rukario71 A CROWNing moment @ a STAG party w/an INFLATED atmosphere. So much PRESSURE to nÃ¢â¬Â¦ https://t.co/n8vaADzCXr
935                                                                                                                                                                             One year ago today. Ã­Â Â½Ã­Â°Â· I miss you and our silly shenanigans. 3 weeksÃ¢â¬Â¦ https://t.co/3yTgf7tF3U
936                                                                                                                                                                                                          Brunch with a view! \n#UWclub #Seattle @ UW Faculty Club https://t.co/phTLlBS0fY
937                                                                                                                                        "Ever had a breast cancer survivor cry in your office worried that she caused her cancer by wearing bras for 20 yrsÃ¢â¬Â¦ https://t.co/SqtILKEkVk
938                                                                                                                                                                                                                               @Swagg_Wizard aww i love u, youÃ¢â¬â¢re doing gr8 sweetie
939                                                                                                                                     RT @jseattle: --&gt; "Advertising space next to Capitol Hill Broadway Sound Transit station" https://t.co/TJVfsABUdp "Please give us your offeÃ¢â¬Â¦
940                                                                                                                                     --&gt; "Advertising space next to Capitol Hill Broadway Sound Transit station" https://t.co/TJVfsABUdp "Please give usÃ¢â¬Â¦ https://t.co/tviuJU3CQ9
941                                                                                                                                                              RT @jseattle: Latest round of Neighborhood Matching Fund matching grants announced. Good stuff in D3 https://t.co/Wr4oTJByfW
942                                                                                                                                                                            Latest round of Neighborhood Matching Fund matching grants announced. Good stuff in D3 https://t.co/Wr4oTJByfW
943                                                                                                                                                                      15th annual uw drag show TONIGHT!\n@asuwseattle @uwqcenter @uwstudentlife @thedailyuw @uofwa https://t.co/szikc5Vii1
944                                                                                                                                                               #Sounders fans are starting to pull in to port ahead of Portland game this weekend cc: @NosAudietis https://t.co/fSIyMDwcrl
945                                                                                                                                                                                                     RT @jseattle: There are still Republicans in King County #tbt https://t.co/gCv1F5vonv
946                                                                                                                                                                                                                   There are still Republicans in King County #tbt https://t.co/gCv1F5vonv
947                                                                                                                                                           RT @jseattle: Tonight: Capitol Hill Housing Community Forum: Own It! Prevent Displacement, Build Wealth https://t.co/BP3einT2pI
948                                                                                                                                                                                                                Baerlic Woodworker Barrel Aged Series Black Grove  https://t.co/g2oR900SWZ
949                                                                                                                                                                                                           RT @jseattle: Taking over former Edie's space on E Pike https://t.co/xvR2ThgCyc
950                                                                                                                                                                                              RT @jseattle: Free burgers again for Memorial Day. Thanks @lilwoodys https://t.co/DigUrtw3wu
951                                                                                                                                                                                                            Free burgers again for Memorial Day. Thanks @lilwoodys https://t.co/DigUrtw3wu
952                                                                                                                                                                         Tonight: Capitol Hill Housing Community Forum: Own It! Prevent Displacement, Build Wealth https://t.co/BP3einT2pI
953                                                                                                                                                                                                                         Taking over former Edie's space on E Pike https://t.co/xvR2ThgCyc
954                                                                                                                                                                                                                                           RT @jseattle: good news https://t.co/wAG8ZeNpBB
955                                                                                                                                                                                                                                                         good news https://t.co/wAG8ZeNpBB
956                                                                                                                                     You guys made postsurgery so much more worth it. It means the world you that you guys came &amp; sat for hours just toÃ¢â¬Â¦ https://t.co/S31n3jvikp
957                                                                                                                                                                                                                        STOLEN - Black Marin Bikes Muirwoods 29er  https://t.co/ag5JY6R9SU
958                                                                                                                                                                                                                                             RT @jseattle: Lawsuit https://t.co/6SFiXjLErK
959                                                                                                                                                          21 21 21\n\nWe've had some close calls but we finally see the day THE BOI @trulyadub  becomes THEÃ¢â¬Â¦ https://t.co/PRlYj5CKKq
960                                                                                                                                                                                                                                                           Lawsuit https://t.co/6SFiXjLErK
961                                                                                                                                                                                           #offbrandwaitwaitdonttellme with PNW superstars Lindy West, LukeÃ¢â¬Â¦ https://t.co/vjs7Kl5PiU
962                                                                                                                                                         There are so many opportunities to show up to our lives in a real way. Ã¢ÅÂ¨\nTo make eye contactÃ¢â¬Â¦ https://t.co/VLprImOcui
963                                                                                                                                                                                       STOLEN - Green Novara Randonee in Northwest Seattle https://t.co/UK20God55t https://t.co/1onHzWphcy
964                                                                                                                                                          "By practicing #meditation we establish love, compassion and equanimity as our home." - Sharon Salzberg. https://t.co/u2YsCSHt9I
965                                                                                                                                                                                                            Obviously not a real @wsdot or @seattledot signÃ¢â¬Â¦ https://t.co/ZaFsZWwlWW
966                                                                                                                                                                                                                            POE Capstone Symposium! Happening right now! #POEcap #envir490
967                                                                                                                       RT @jseattle: Finally, a $23.25M deal Ã¢â¬â and plans for inclusive development Ã¢â¬â at 23rd andÃÂ Union https://t.co/8rU7nyXD4i https://t.co/2T3N8CÃ¢â¬Â¦
968                                                                                                                                                                                                                          RT @jseattle: Meanwhile at 23rd and Jax: https://t.co/Of6IkQrjb5
969                                                                                                                                                                                                                                        Meanwhile at 23rd and Jax: https://t.co/Of6IkQrjb5
970                                                                                                                                        Finally, a $23.25M deal Ã¢â¬â and plans for inclusive development Ã¢â¬â at 23rd andÃÂ Union https://t.co/8rU7nyXD4i https://t.co/2T3N8Cl850
971                                                                                                                                                                                                                                all code and no design makes jack a very [frustrated] boy.
972                                                                                                                                                Lessons from Mike Mondello from @seabear1957 on #resilience and how to mentor it, at @UWFosterSchool. #BeBoundless https://t.co/miQmX3Z9mw
973                                                                                                                                         Pretty wrist cuff that I added below some work she already had #wristtattoo #mandalatattoo #seattle #seattletattooÃ¢â¬Â¦ https://t.co/sfRHX4GJkB
974                                                                                                                                                             9 years ago I was excitedly posting about going to @Sasquatch This year I get to perform in itÃ¢â¬Â¦ https://t.co/BIjwcYkUYk
975                                                                                                                                                                                                          When it's 80 degrees in Seattle and I'm trapped indoors &lt;&lt;&lt;&lt;&lt;&lt;
976                                                                                                                                                                                                  STOLEN - Blue Giant TCX 1 in Wallingford https://t.co/QBc6Z7zjm8 https://t.co/0T3o5896JH
977                                                                                                                                                         Looking for a new job opportunity? Download the Instawork App to get started.\n.\n.\n.\n#instaworkÃ¢â¬Â¦ https://t.co/tyXelyZrOk
978                                                                                                                                                                                                 Seeing Red Ã­Â Â½Ã­Â¸Â Ã­Â Â½Ã­Â³Â·: @tmnlsn @ Henry Art Gallery https://t.co/8fNzTDEUtl
979                                                                                                                                         Finished up these adorable cats! #cattattoo #cattoo #pettattoo #petportrait #petsarefamily #seattle #seattletattooÃ¢â¬Â¦ https://t.co/YADyqFIMvc
980                                                                                                                                                                                                                               J chillin, J floatin @ Montlake Cut https://t.co/3CbXXUvELv
981                                                                                                                                                                                                                        Just posted a photo @ Wallingford, Seattle https://t.co/0M6ydHmGg3
982                                                                                                                                                                                                                                                     "Snark can't halt tectonic shifts" ok
983                                                                                                                                                                                                     I'm glad I'm not the only person who has asked this question. https://t.co/kNBiUWoJZF
984                                                                                                                                                                     To all the people who make Husky Football GREAT..... @ Alaska Airlines Field at Husky Stadium https://t.co/2wMbJgYWUU
985                                                                                                                                        Thanks @cliffavril @mosesbread72 and @Bwagz54 for supporting Beat the Bridge to cure T1D. The race started when I wÃ¢â¬Â¦ https://t.co/iU0LDWjrG0
986                                                                                                                                                                                                                 How I imagine 3D printing vs. actual 3D printing. https://t.co/QQIVGqVuov
987                                                                                                                                                                                                                                                                        Don't get too lost
988                                                                                                                                                                                                                                              It's a beautiful day https://t.co/KfqlkdsQr3
989                                                                                                                                               Perfect day on Montlake for ball!  @USC_Baseball at @UW_Baseball wrap up regular season at 4pm PT on @Pac12Network. https://t.co/M60q8I1m0o
990                                                                                                                                                                                                                           STOLEN - Red Epic  in Northeast Seattle https://t.co/LG5wXr0oqc
991                                                                                                                                                                        Husky Stadium-The Greatest Setting In College Football, from the air. #HuskyStadiumÃ¢â¬Â¦ https://t.co/iLQbLd737C
992                                                                                                                                                           Beautiful day to be flying @kenmoreair Lake Union Seattle #kenmoreair #lakeunion #seattle #pilotÃ¢â¬Â¦ https://t.co/N5txh80231
993                                                                                                                                                                               Ã­Â Â½Ã­Â²Å @havanajane making @uw_wsoccer uwathletics proud tonight at theÃ¢â¬Â¦ https://t.co/yFoWXvQN0i
994                                                                                                                                                  I'm starving! I think I'll head over to the U village Ram for a burger and help support the Roosevelt HS cheer team #WOOF #DawgsGottaEat
995                                                                                                                                             Always enjoy when our @UW sociology students present their research. @AlexesHarris @frankalready @RalinaJosephÃ¢â¬Â¦ https://t.co/brJYI7koZ7
996                                                                                                                                        RT @jseattle: Actually, one more thing. Covering deals and plans, I never could really picture any of this really happening at 23/Union. BuÃ¢â¬Â¦
997                                                                                                                                                Actually, one more thing. Covering deals and plans, I never could really picture any of this really happening at 23/Union. But here it is.
998                                                                                                                                        Panel at @Oweesta and @hawaiiancouncil convening on investing in Native communities. W @Craft3Org Mike Dickerson, TÃ¢â¬Â¦ https://t.co/AzTUEga3jA
999                                                                                                                                                                                           RT @jseattle: Everybody wants to be Mayor of Seattle. What awkward questions should I ask them?
1000                                                                                                                                          "What you care about can change the world." Lovely day on campus to discuss #smartcity initiatives on #mobility,Ã¢â¬Â¦ https://t.co/7fTH4NCCMo
1001                                                                                                                                       RT @jseattle: Civic duty this week: @caphillchamber biz improvement area, Capitol Hill Housing community forum, EastPAC crime mtg  https://Ã¢â¬Â¦
1002                                                                                                                                       RT @jseattle: Civic duty this week: @caphillchamber biz improvement area, Capitol Hill Housing community forum, EastPAC crime mtg  https://Ã¢â¬Â¦
1003                                                                                                                                             Civic duty this week: @caphillchamber biz improvement area, Capitol Hill Housing community forum, EastPAC crime mtg  https://t.co/bziHu4bZ12
1004                                                                                                                                                                                                        Everybody wants to be Mayor of Seattle. What awkward questions should I ask them?
1005                                                                                                                                                                 "Bear" just might be the cutest #T1d service dog I've ever met!! He's 15 weeks old with aÃ¢â¬Â¦ https://t.co/q0ptoJddoo
1006                                                                                                                                                                                                 IÃ¢â¬â¢m super overtired right now. Perfect time for cuddles ~ https://t.co/nK3feXf8Ga
1007                                                                                                                                                                                                                     STOLEN - Black Trek 820 in Northeast Seattle https://t.co/H4bxSsbbhV
1008                                                                                                                                                       .@UW engineering students gain real world experience by building a 2-man, human powered submarine. #Q13FOX https://t.co/pYmSUYvoiA
1009                                                                                                                                                                                       RT @jseattle: I thought conservative millennials wanted smaller government https://t.co/A7zF7VOUTN
1010                                                                                                                                                                                       RT @jseattle: I thought conservative millennials wanted smaller government https://t.co/A7zF7VOUTN
1011                                                                                                                                                                                       RT @jseattle: I thought conservative millennials wanted smaller government https://t.co/A7zF7VOUTN
1012                                                                                                                                                                                                     I thought conservative millennials wanted smaller government https://t.co/A7zF7VOUTN
1013                                                                                                                                       BREAKING: Large number of @SeattlePD some with long guns at Gas Works Park after reported shooting. 2 possible victÃ¢â¬Â¦ https://t.co/eVHnZijbFX
1014                                                                                                                                       RT @jseattle: With new Midtown Project, developer will add 550 units. Lake Union Partners already has 275 at the intersection https://t.co/Ã¢â¬Â¦
1015                                                                                                                                       RT @jseattle: With new Midtown Project, developer will add 550 units. Lake Union Partners already has 275 at the intersection https://t.co/Ã¢â¬Â¦
1016                                                                                                                                                  With new Midtown Project, developer will add 550 units. Lake Union Partners already has 275 at the intersection https://t.co/8rU7nyG1FI
1017                                                                                                                                                                                                  You must be from Russia because you make blood Russian my penis https://t.co/FOEEZm165d
1018                                                                                                                                                                                       RT @jseattle: June 19th: Groundbreaking Ceremony for Liberty Bank Building https://t.co/GtQqjDK0WG
1019                                                                                                                                                                                       RT @jseattle: June 19th: Groundbreaking Ceremony for Liberty Bank Building https://t.co/GtQqjDK0WG
1020                                                                                                                                                                                       RT @jseattle: June 19th: Groundbreaking Ceremony for Liberty Bank Building https://t.co/GtQqjDK0WG
1021                                                                                                                                                                                       RT @jseattle: June 19th: Groundbreaking Ceremony for Liberty Bank Building https://t.co/GtQqjDK0WG
1022                                                                                                                                                                                                     June 19th: Groundbreaking Ceremony for Liberty Bank Building https://t.co/GtQqjDK0WG
1023                                                                                                                                                           RT @jseattle: You might want to start getting in line soon, @saltandstraw fans https://t.co/ePpQiwXTyo https://t.co/u4ufGI02cd
1024                                                                                                                                                           RT @jseattle: You might want to start getting in line soon, @saltandstraw fans https://t.co/ePpQiwXTyo https://t.co/u4ufGI02cd
1025                                                                                                                                                           RT @jseattle: You might want to start getting in line soon, @saltandstraw fans https://t.co/ePpQiwXTyo https://t.co/u4ufGI02cd
1026                                                                                                                                                           RT @jseattle: You might want to start getting in line soon, @saltandstraw fans https://t.co/ePpQiwXTyo https://t.co/u4ufGI02cd
1027                                                                                                                                                           RT @jseattle: You might want to start getting in line soon, @saltandstraw fans https://t.co/ePpQiwXTyo https://t.co/u4ufGI02cd
1028                                                                                                                                                                         You might want to start getting in line soon, @saltandstraw fans https://t.co/ePpQiwXTyo https://t.co/u4ufGI02cd
1029                                                                                                                                           Tim Lincecum Night in Seattle for @USC_Baseball at @UW_Baseball.  Scott Erickson &amp; I have it 7pm on @Pac12Network. https://t.co/ZnB5Bot1uF
1030                                                                                                                                         Some thoughts on assumptions in the design of personal informatics &amp; self-tracking tools, and ways to move past them https://t.co/mRfv8y8abK
1031                                                                                                                                       You guys ever hear @KeyboardKid206 tell his story? Fuck no you haven't, listen on @theglowupcast! Thanks again fam!Ã¢â¬Â¦ https://t.co/9zBbI1G5Vl
1032                                                                                                                                                                                                                          Oh lord is this rly real? @iamblackbear https://t.co/DnHOCoD9fs
1033                                                                                                                                                                                                                They Don't Want You To Wear All Pink Ã­Â Â½Ã­Â¸Â¤ https://t.co/X1GXLbYBG4
1034                                                                                                                                       Getting ready for TEDx at UW, which begins at 11:00 in Kane Hall - Yes, and." I'll b talking abt "Bridges" - bldg tÃ¢â¬Â¦ https://t.co/AFQeJmwZWt
1035                                                                                                                                                                                                                                                   SO horny hnnng https://t.co/9pBPVgFWaT
1036                                                                                                                         Ã­Â Â½Ã­Â²ÅÃ­Â Â½Ã­Â²ÅÃ­Â Â½Ã­Â²ÅIf anyone knows THIS grind it's our #2009 team! Our backs were against the wall MANY time andÃ¢â¬Â¦ https://t.co/5X4lmb45Pv
1037                                                                                                                                                                                                                                 It's oyster season motherfricker https://t.co/lI48wOF01G
1038                                                                                                                              Q: WhatÃ¢â¬â¢s a furry?\nA: A millennial whoÃ¢â¬â¢s realized contemporary Western society is a failed project &amp; has withdrawn to party till dead :3
1039                                                                                                                                                                                                                            You can book it. @UWSoftball #Dawgman https://t.co/dmc8BYFNie
```


Twitter Stream with streamR
====================================================================================

There are a few packages that can access the Twitter Stream API including `streamR`.
Since the Stream API is less commonly used in Social Science, the packages are a bit 
"rough around the edges" and require more finicky setup.

This is likely to change over time as more people make use of the Stream API.


streamR Setup
====================================================================================


```r
download.file(url="http://curl.haxx.se/ca/cacert.pem",
              destfile="cacert.pem")
twitCred <- OAuthFactory$new(consumerKey=api_key,
                             consumerSecret=api_secret,
                             requestURL=reqURL,
                             accessURL=accessURL,
                             authURL=authURL)

# insert the number in the R console after you run this
twitCred$handshake(cainfo = 
            system.file("CurlSSL", "cacert.pem", package = "RCurl"))

# Then save this so you don't need to do it again
save(twitCred, file = "twitCred.Rdata")
```


streamR
====================================================================================
incremental: true

`sampleStream()` downloads streaming tweets of no particular topic.


```r
tweets_stream <- sampleStream("", timeout=10, oauth=twitCred)
```

`filterStream()` downloads streaming tweets based on search parameters.


```r
tweets_Trump  <- filterStream("", track="Trump", timeout=10, oauth=twitCred)
```

The first argument for both functions is the path to write tweets to. `""` writes
the tweets to the console. This permits assignment to an object.

streamR
====================================================================================
incremental: true

Once you've streamed data in you need to parse it from JSON format into a data frame 
for it to be particularly useful.


```r
tweets_from_stream <- parseTweets(tweets_stream, verbose = FALSE)
as_tibble(tweets_from_stream) %>% arrange(followers_count) %>% select(name)
```


```
# A tibble: 240 x 1
                                                                                                                                                               name
                                                                                                                                                              <chr>
 1                                                                                                                                                     Helen Howell
 2                                                                                                                                                Chococaromishanos
 3 <U+7D20><U+6575><U+306A><U+30A4><U+30E9><U+30B9><U+30C8><U+63CF><U+304D><U+69D8><U+3092><U+4E16><U+754C><U+306B><U+5E83><U+3081><U+307E><U+3057><U+3087><U+3046>
 4                                                                                                                                                      Jutino Ñato
 5                                                                                                                                                  Pepe Concepción
 6                                                                                                                                                   DíaJaramishano
 7                                                                                                                                                ChocoJaramishanos
 8                                                                                                                                                        masayoshi
 9                                                                                                                                                  JaramishanosMMD
10                                                                                                                                                        Black cat
# ... with 230 more rows
```


Using streamR
====================================================================================

Since it collects tweets in real time, the streaming API tends to be most useful when you leave it running *for a long time*.

You can use it to monitor events as they're happening, or to catch a "snapshot" in time.

I let it run for 1200 seconds to replicate an example by the package author, Pablo Barbera, 
in which tweets in the US are collected and then mapped in ggplot.


Using streamR
====================================================================================


```r
filterStream("tweetsUS.json", locations = c(-125, 25, -66, 50), timeout = 1200, 
             oauth = twitCred)
tweets.df <- parseTweets("tweetsUS.json", verbose = FALSE)
map.data <- map_data("state")
points <- data.frame(x=as.numeric(tweets.df$lon), y=as.numeric(tweets.df$lat))
points <- points[points$y > 25, ]
ggplot(map.data) + geom_map(aes(map_id=region), map=map.data, fill="white", 
                            color = "grey20", size = 0.25) + 
  expand_limits(x = map.data$long, y = map.data$lat) + 
  theme(axis.line = element_blank(), axis.text = element_blank(), 
        axis.ticks = element_blank(), axis.title = element_blank(), 
        panel.background = element_blank(), panel.border = element_blank(), 
        panel.grid.major = element_blank(), plot.background=element_blank(), 
        plot.margin = unit(0 * c(-1.5, -1.5, -1.5, -1.5), "lines")) + 
  geom_point(data=points, aes(x=x, y=y), size=1, alpha=1/5, color="darkblue")
```


Using streamR
====================================================================================

<img src="CSSS508_week10_scraping-figure/big_stream_actual-1.png" title="plot of chunk big_stream_actual" alt="plot of chunk big_stream_actual" width="1100px" height="600px" />


Using Twitter Data
====================================================================================

Getting data from social media is easy with `SocialMediaLab` (it used to be hard!).

Typically we use these data for:

* Text mining (covered today)
* Network analysis (CS&SS567: Analysis of Social Network Data)


Example Network Graphs
====================================================================================

![https://github.com/vosonlab/SocialMediaLab](starwars_network.png)


Analyzing Twitter Text Data
====================================================================================

Large volumes of text data can be challenging to make sense of, so they are most useful when
approached using text analysis techniques.

But even they might not help with some kinds of text:

![](covfefe.PNG)



Text Mining with tm
====================================================================================
type: section


What is Text Mining?
====================================================================================

Text mining is a form of text analytics, that is a process for extracting information
from text intended to be read by humans.

Text mining can cover things like categorization of subjects, sentiment analysis, and
automated summarization.

Typically we want to take a very large amount of text---often from many different 
documents or sources---and produce useful numerical and textual summaries.

Text mining is very commonly done with content from social media data!


Text Mining Terminology
====================================================================================

* `tm`: R package for performing text mining
* **Term**: A word
* **Document**: A collection of *terms*
* **Corpus**: A collection of *documents* (plural: corpora)
* **Dictionary**: A set of relevant *terms*


My First Corpus
====================================================================================

We can make a basic corpus manually by creating a character vector, running `VectorSource()` on it to read it in, and then `VCorpus()` to corpus-ify:


```r
library(tm)
UW_tweets <- c("Remembering and honoring those who made the ultimate sacrifice while serving our country. #MemorialDay2016",
               "VIDEO: This spring @UW students taught literacy arts to #Colville Reservation students. Check out book they made!",
               "Enjoy the long weekend, Huskies! And to those studying for finals: Good luck and hang in there!",
               ".@UWBuerk & @UWFosterSchool–hosted biz plan competition awards $85,000 to students for new ventures. http://ow.ly/3PtI300F87Y  #UWinnovates")
toy_corpus <- VCorpus(VectorSource(UW_tweets))
```


Accessing Corpus Entries
====================================================================================

A corpus is just a fancy list of documents, and you can access a document as a list entry:


```r
toy_corpus[[3]]
```

```
<<PlainTextDocument>>
Metadata:  7
Content:  chars: 95
```

```r
as.character(toy_corpus[[3]])
```

```
[1] "Enjoy the long weekend, Huskies! And to those studying for finals: Good luck and hang in there!"
```


Text Files as Documents
====================================================================================

You will more likely be making corpora from sources like Twitter or reading in data from text files. 

We'll import a sample of emails from the [Enron corpus](http://bailando.sims.berkeley.edu/enron_email.html) assembled by UC Berkeley students. First, let's download a ZIP file with the text files and unzip it.


```r
download.file("http://clanfear.github.io/CSSS508/Lectures/Week10/enron_sample_emails.zip", destfile = "enron_emails.zip", mode = "wb")
unzip("enron_emails.zip", exdir = "enron_emails")
```


```r
length(list.files("enron_emails/enron_sample_emails"))
```

```
[1] 100
```


Reading in Text Files
====================================================================================

Let's make a corpus where each document is an email in the Enron subsample:


```r
enron_corpus <- VCorpus(DirSource(directory = "enron_emails/enron_sample_emails", mode = "text"))
as.character(enron_corpus[[3]])
```

```
 [1] "Message-ID: <26658543.1075843310470.JavaMail.evans@thyme>"                      
 [2] "Date: Fri, 22 Dec 2000 04:00:00 -0800 (PST)"                                    
 [3] "From: sarah.novosel@enron.com"                                                  
 [4] "To: susan.mara@enron.com"                                                       
 [5] "Subject: Re: Wolak report"                                                      
 [6] "Cc: donna.fulton@enron.com, jeff.dasovich@enron.com"                            
 [7] "Mime-Version: 1.0"                                                              
 [8] "Content-Type: text/plain; charset=us-ascii"                                     
 [9] "Content-Transfer-Encoding: 7bit"                                                
[10] "Bcc: donna.fulton@enron.com, jeff.dasovich@enron.com"                           
[11] "X-From: Sarah Novosel"                                                          
[12] "X-To: Susan J Mara"                                                             
[13] "X-cc: Donna Fulton, Jeff Dasovich"                                              
[14] "X-bcc: "                                                                        
[15] "X-Folder: \\Jeff_Dasovich_June2001\\Notes Folders\\All documents"               
[16] "X-Origin: DASOVICH-J"                                                           
[17] "X-FileName: jdasovic.nsf"                                                       
[18] ""                                                                               
[19] "Sue:"                                                                           
[20] ""                                                                               
[21] "I'm so impressed that you know how to put the link on the email.  I can't "     
[22] "figure out how to do that, and I think that looks much more \"high tech\" than "
[23] "attaching a silly old report."                                                  
[24] ""                                                                               
[25] "Thanks for the link.  We can take it from here.  "                              
[26] ""                                                                               
[27] "Sarah"                                                                          
[28] ""                                                                               
[29] ""                                                                               
[30] ""                                                                               
[31] ""                                                                               
[32] ""                                                                               
[33] "\tSusan J Mara"                                                                  
[34] "\t12/22/2000 11:31 AM"                                                           
[35] "\t\t "                                                                            
[36] "\t\t To: Sarah Novosel/Corp/Enron@ENRON, Donna Fulton/Corp/Enron@ENRON"           
[37] "\t\t cc: Jeff Dasovich/NA/Enron@Enron"                                            
[38] "\t\t Subject: Wolak report"                                                       
[39] ""                                                                               
[40] "Call me computer illiterate. I could not figure out how to download the "       
[41] "report off the web site, so here's the link."                                   
[42] ""                                                                               
[43] " "                                                                              
[44] " http://www.caiso.com/docs/2000/12/12/2000121215070918957.pdf"                  
```

Transformations (Maps)
====================================================================================
incremental: true

To prepare this text, we want to: 

1. Change text to lowercase
2. Remove: 
   * Stopwords (words that do not contain useful information)
   * Header terms
   * Punctuation
   * Numbers
   * Whitespace
3. "Stem" the words (strip prefixes and suffixes)

Then we can actually do analysis!


Transformations Syntax
====================================================================================


```r
# install.packages("SnowballC") # may solve errors
enron_stripped <- enron_corpus %>%
    tm_map(content_transformer(str_to_lower)) %>%
    tm_map(removeWords, stopwords("english")) %>%
    tm_map(removeWords, 
        c("javamail.evans@thyme", "message-id", "date", "subject", 
         "mime-version", "content-type", "text/plain", "charset=us-ascii", 
         "content-transfer-encoding", "x-", "x-cc", "x-bcc", "x-folder", 
         "x-origin", "x-filename")) %>%
    tm_map(removePunctuation) %>%
    tm_map(removeNumbers) %>%
    tm_map(stripWhitespace) %>%
    tm_map(stemDocument)
```

Word Clouds
====================================================================================


```r
library(wordcloud); library(RColorBrewer)
wordcloud(enron_stripped, min.freq = 2, max.words = 80)
```

<img src="CSSS508_week10_scraping-figure/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" width="1100px" height="440px" />


Filtering to Emails with "California"
====================================================================================

We'll write a function that takes the content of the documents and looks for any instance of `"california"`, then use it with `tm_filter()`:


```r
doc_word_search <- function(x, pattern) {
    any(str_detect(content(x), pattern = pattern))
}
cali_emails <- enron_stripped %>%
    tm_filter(doc_word_search, pattern = "california")
length(cali_emails)
```

```
[1] 14
```


Term-Document Matrices
====================================================================================

We can look for patterns across the documents by constructing a `TermDocumentMatrix()`:


```r
enron_tdm <- TermDocumentMatrix(enron_stripped)
str(enron_tdm)
```

```
List of 6
 $ i       : int [1:17721] 2 9 12 15 17 19 24 27 30 34 ...
 $ j       : int [1:17721] 1 1 1 1 1 1 1 1 1 1 ...
 $ v       : num [1:17721] 4 1 1 1 1 2 1 1 2 4 ...
 $ nrow    : int 5061
 $ ncol    : int 100
 $ dimnames:List of 2
  ..$ Terms: chr [1:5061] "abat" "abil" "abl" "abnorm" ...
  ..$ Docs : chr [1:100] "114495.txt" "115323.txt" "118675.txt" "119214.txt" ...
 - attr(*, "class")= chr [1:2] "TermDocumentMatrix" "simple_triplet_matrix"
 - attr(*, "weighting")= chr [1:2] "term frequency" "tf"
```

What Does the Matrix Look Like?
====================================================================================

Too big to view at once, but we can look at snippets with `inspect()`:


```r
inspect(enron_tdm[1:5, 1:5])
```

```
<<TermDocumentMatrix (terms: 5, documents: 5)>>
Non-/sparse entries: 2/23
Sparsity           : 92%
Maximal term length: 7
Weighting          : term frequency (tf)
Sample             :
         Docs
Terms     114495.txt 115323.txt 118675.txt 119214.txt 12030.txt
  abat             0          0          0          0         0
  abil             4          0          0          0         0
  abl              0          0          0          0         1
  abnorm           0          0          0          0         0
  abolish          0          0          0          0         0
```

Removing Sparse Words
====================================================================================

We could focus on words that appear in at least 40% of documents.


```r
enron_tdm_sparse <- removeSparseTerms(enron_tdm, 0.60)
inspect(enron_tdm_sparse)
```

```
<<TermDocumentMatrix (terms: 11, documents: 100)>>
Non-/sparse entries: 659/441
Sparsity           : 40%
Maximal term length: 18
Weighting          : term frequency (tf)
Sample             :
                    Docs
Terms                114495.txt 173842.txt 174212.txt 174517.txt
  bit                         1          1          0          1
  document                    2          1          1          1
  folder                      1          1          1          1
  forward                     3          1          1          5
  kean                        0          2          2          2
  pdt                         1          1          1          1
  steven                      0          3          2          3
  stevenkeanenroncom          0          1          1          1
  thank                       2          1          0          1
  will                       19          4          8          6
                    Docs
Terms                175607.txt 175617.txt 176601.txt 176805.txt
  bit                         1          1          1          1
  document                    3          1          1          2
  folder                      1          1          1          0
  forward                     8          1          0          8
  kean                        1          2          2          1
  pdt                         0          0          1          0
  steven                      0          3          1          0
  stevenkeanenroncom          0          1          1          0
  thank                       1          4          4          1
  will                       73          2          5         73
                    Docs
Terms                177215.txt 255511.txt
  bit                         1          2
  document                    2          2
  folder                      0          1
  forward                     8          3
  kean                        1          0
  pdt                         0          1
  steven                      0          0
  stevenkeanenroncom          0          0
  thank                       1          2
  will                       73         19
```


Favorite Dictionary Words
====================================================================================

Or we can make make a term-document matrix focusing on words in a dictionary and look at just those columns:


```r
inspect(TermDocumentMatrix(enron_stripped, list(dictionary = c("california", "utah", "texas")))[, 1:5])
```

```
<<TermDocumentMatrix (terms: 3, documents: 5)>>
Non-/sparse entries: 2/13
Sparsity           : 87%
Maximal term length: 10
Weighting          : term frequency (tf)
Sample             :
            Docs
Terms        114495.txt 115323.txt 118675.txt 119214.txt 12030.txt
  california          1          1          0          0         0
  texas               0          0          0          0         0
  utah                0          0          0          0         0
```


Most Frequent Words
====================================================================================

Which terms appear at least 200 times?


```r
findFreqTerms(enron_tdm, 200)
```

```
 [1] "california" "compani"    "contract"   "electr"     "energi"    
 [6] "gas"        "generat"    "market"     "new"        "plant"     
[11] "power"      "price"      "said"       "state"      "time"      
[16] "util"       "will"       "year"      
```


Word Associations
====================================================================================

Which words co-occur frequently with "california"?

```r
findAssocs(enron_tdm, "california", 0.90)
```

```
$california
                             citizen                               condit 
                                1.00                                 1.00 
                              consum                               credit 
                                1.00                                 1.00 
                              dynegi                            economist 
                                1.00                                 1.00 
                              electr                               energi 
                                1.00                                 1.00 
                              enough                              essenti 
                                1.00                                 1.00 
                                forc                               higher 
                                1.00                                 1.00 
                              includ                              increas 
                                1.00                                 1.00 
                            investig                                locat 
                                1.00                                 1.00 
                              market                                order 
                                1.00                                 1.00 
                               power                                press 
                                1.00                                 1.00 
                              provid                                regul 
                                1.00                                 1.00 
                             reliabl                               report 
                                1.00                                 1.00 
                                roll                           sacramento 
                                1.00                                 1.00 
                            statewid                                 step 
                                1.00                                 1.00 
                            structur                               summer 
                                1.00                                 1.00 
                              suppli                                three 
                                1.00                                 1.00 
                             weather                                whose 
                                1.00                                 1.00 
                              abnorm                              abolish 
                                0.99                                 0.99 
                             abraham                              absolut 
                                0.99                                 0.99 
                              access                           accomplish 
                                0.99                                 0.99 
                               accru                              accumul 
                                0.99                                 0.99 
                               accus                               achiev 
                                0.99                                 0.99 
                          acknowledg                             acquisit 
                                0.99                                 0.99 
                               actor                                 acut 
                                0.99                                 0.99 
                                adam                                  add 
                                0.99                                 0.99 
                               addit                             addresse 
                                0.99                                 0.99 
                            adequaci                                adjac 
                                0.99                                 0.99 
                              adjust                                adopt 
                                0.99                                 0.99 
                            advantag                               advers 
                                0.99                                 0.99 
                               advoc                             advocaci 
                                0.99                                 0.99 
                              affect                                agenc 
                                0.99                                 0.99 
                               agent                              aggress 
                                0.99                                 0.99 
                                 aid                                  air 
                                0.99                                 0.99 
                             airport                              alamito 
                                0.99                                 0.99 
                               alarm                               albani 
                                0.99                                 0.99 
                               alert                                 aliv 
                                0.99                                 0.99 
                           allegheni                              alliant 
                                0.99                                 0.99 
                               allot                                allow 
                                0.99                                 0.99 
                                alon                                 also 
                                0.99                                 0.99 
                              altern                             altogeth 
                                0.99                                 0.99 
                               amass                                amoco 
                                0.99                                 0.99 
                                amok                                 ampl 
                                0.99                                 0.99 
                             analysi                                angel 
                                0.99                                 0.99 
                             angelid                                angus 
                                0.99                                 0.99 
                              anjali                               annual 
                                0.99                                 0.99 
                        anticompetit                            antitrust 
                                0.99                                 0.99 
                             antonio                              anywher 
                                0.99                                 0.99 
                            appendix                                 appl 
                                0.99                                 0.99 
                            applianc                             appointe 
                                0.99                                 0.99 
                              approv                                 arco 
                                0.99                                 0.99 
                                argu                              arguabl 
                                0.99                                 0.99 
                                aros                               arrang 
                                0.99                                 0.99 
                              arrest                             artifici 
                                0.99                                 0.99 
                                asid                               aspect 
                                0.99                                 0.99 
                             assembl                          assemblyman 
                                0.99                                 0.99 
                              assert                             atkinson 
                                0.99                                 0.99 
                              attack                             attorney 
                                0.99                                 0.99 
                            attribut                                audra 
                                0.99                                 0.99 
                             augusta                              automat 
                                0.99                                 0.99 
                               avail                               averag 
                                0.99                                 0.99 
                               avert                                await 
                                0.99                                 0.99 
                               award                               aybear 
                                0.99                                 0.99 
                              backup                             backyard 
                                0.99                                 0.99 
                                 bad                          bakersfield 
                                0.99                                 0.99 
                              balanc                               bangor 
                                0.99                                 0.99 
                          bankruptci                                  bar 
                                0.99                                 0.99 
                                barg                              bargain 
                                0.99                                 0.99 
                                barn                                basic 
                                0.99                                 0.99 
                               basin                               battin 
                                0.99                                 0.99 
                                bccd                               beaten 
                                0.99                                 0.99 
                                 bed                                begun 
                                0.99                                 0.99 
                              beloit                            benchmark 
                                0.99                                 0.99 
                             benefit                             berkeley 
                                0.99                                 0.99 
                            berkshir                    berkshirehathaway 
                                0.99                                 0.99 
                           bernadino                             berthold 
                                0.99                                 0.99 
                               besid                                beyer 
                                0.99                                 0.99 
                              bigger                              biggest 
                                0.99                                 0.99 
                             billion                              biomass 
                                0.99                                 0.99 
                              bitten                                black 
                                0.99                                 0.99 
                            blackout                                bless 
                                0.99                                 0.99 
                               blunt                                blyth 
                                0.99                                 0.99 
                                bond                                bonus 
                                0.99                                 0.99 
                               boost                               border 
                                0.99                                 0.99 
                          borderless                           borenstein 
                                0.99                                 0.99 
                                born                            bostonbas 
                                0.99                                 0.99 
                              bought                               bounti 
                                0.99                                 0.99 
                               bowen                                 bowr 
                                0.99                                 0.99 
                              breach                                break 
                                0.99                                 0.99 
                           breakdown                                brick 
                                0.99                                 0.99 
                               bridg                                brink 
                                0.99                                 0.99 
                             british                                 brka 
                                0.99                                 0.99 
                            broadbas                            broadcast 
                                0.99                                 0.99 
                               brown                             budhraja 
                                0.99                                 0.99 
                             buffett                                built 
                                0.99                                 0.99 
                                bulk                                 bump 
                                0.99                                 0.99 
                          bureaucrat                              burglar 
                                0.99                                 0.99 
                              burton                             bustillo 
                                0.99                                 0.99 
                               bustl                                caith 
                                0.99                                 0.99 
                           calenergi                                calif 
                                0.99                                 0.99 
                            califbas                        californialik 
                                0.99                                 0.99 
                      californiastyl                        californiatyp 
                                0.99                                 0.99 
                          calipatria                               caliso 
                                0.99                                 0.99 
                            campaign                               cancel 
                                0.99                                 0.99 
                                cape                                 carl 
                                0.99                                 0.99 
                            carolina                                carri 
                                0.99                                 0.99 
                           carsonbas                            cashstrap 
                                0.99                                 0.99 
                               catch                                 caus 
                                0.99                                 0.99 
                             caution                                  cec 
                                0.99                                 0.99 
                               cedar                                 cent 
                                0.99                                 0.99 
                         centraleast                               centro 
                                0.99                                 0.99 
                          chairwoman                              chamber 
                                0.99                                 0.99 
                               charg                              chastis 
                                0.99                                 0.99 
                            cheapest                              chevron 
                                0.99                                 0.99 
                               chose                                circl 
                                0.99                                 0.99 
                                cite                                 citi 
                                0.99                                 0.99 
                             clarifi                                clash 
                                0.99                                 0.99 
                            classifi                        cleanalthough 
                                0.99                                 0.99 
                             cleaner                             cleanest 
                                0.99                                 0.99 
                            clearlak                           closeddoor 
                                0.99                                 0.99 
                             coalfir                            coalgener 
                                0.99                                 0.99 
                               coast                                  cod 
                                0.99                                 0.99 
                             cogener                                 cohn 
                                0.99                                 0.99 
                                cold                             colleagu 
                                0.99                                 0.99 
                              column                               combat 
                                0.99                                 0.99 
                        combinedcycl                                 come 
                                0.99                                 0.99 
                          commentari                              commiss 
                                0.99                                 0.99 
                          commission                             committe 
                                0.99                                 0.99 
                             compani                         companyalong 
                                0.99                                 0.99 
                          companyown                           comparison 
                                0.99                                 0.99 
                             complac                             complain 
                                0.99                                 0.99 
                            compound                              conceiv 
                                0.99                                 0.99 
                             concert                             congener 
                                0.99                                 0.99 
                             congest                              connect 
                                0.99                                 0.99 
                              connel                              conserv 
                                0.99                                 0.99 
                     conservationist                             consolid 
                                0.99                                 0.99 
                             contend                             contenti 
                                0.99                                 0.99 
                             continu                           contractor 
                                0.99                                 0.99 
                            contrari                             contrast 
                                0.99                                 0.99 
                         controversi                              convinc 
                                0.99                                 0.99 
                                cook                               cooper 
                                0.99                                 0.99 
                                 cop                            copyright 
                                0.99                                 0.99 
                             cordova                               corner 
                                0.99                                 0.99 
                          cornerston                            corollari 
                                0.99                                 0.99 
                                 cos                                 cost 
                                0.99                                 0.99 
                         counterpart                               counti 
                                0.99                                 0.99 
                             countri                                  cow 
                                0.99                                 0.99 
                                cpuc                                craft 
                                0.99                                 0.99 
                               crash                             creditor 
                                0.99                                 0.99 
                        creditworthi                                creek 
                                0.99                                 0.99 
                               crisi                                cross 
                                0.99                                 0.99 
                           crossbord                            crossroad 
                                0.99                                 0.99 
                              crunch                                  cub 
                                0.99                                 0.99 
                               cubic                                 curb 
                                0.99                                 0.99 
                             current                               custom 
                                0.99                                 0.99 
                                 cut                              cutback 
                                0.99                                 0.99 
                                cycl                               damrel 
                                0.99                                 0.99 
                              danger                               darken 
                                0.99                                 0.99 
                                davi                                  day 
                                0.99                                 0.99 
                            dboulder                              dbuxton 
                                0.99                                 0.99 
                              dcalif                              deadlin 
                                0.99                                 0.99 
                           dealbreak                                 dean 
                                0.99                                 0.99 
                               deast                                debat 
                                0.99                                 0.99 
                               debra                                decri 
                                0.99                                 0.99 
                               dedic                               deeper 
                                0.99                                 0.99 
                              defend                                  del 
                                0.99                                 0.99 
                               deleg                                delic 
                                0.99                                 0.99 
                               delta                               demand 
                                0.99                                 0.99 
                           demandsid                              denounc 
                                0.99                                 0.99 
                              depart                               depend 
                                0.99                                 0.99 
                              deplor                              deregul 
                                0.99                                 0.99 
                              design                                desir 
                                0.99                                 0.99 
                              despit                               detmer 
                                0.99                                 0.99 
                             deulloa                                devis 
                                0.99                                 0.99 
                              devolv                              diametr 
                                0.99                                 0.99 
                               diann                                  dig 
                                0.99                                 0.99 
                             dilemma                                dilig 
                                0.99                                 0.99 
                            diminish                              dirtier 
                                0.99                                 0.99 
                          disappoint                               disast 
                                0.99                                 0.99 
                            discharg                              disclos 
                                0.99                                 0.99 
                             dismiss                             dispatch 
                                0.99                                 0.99 
                             disrupt                              distant 
                                0.99                                 0.99 
                            distress                             district 
                                0.99                                 0.99 
                             dittmer                               divers 
                                0.99                                 0.99 
                          divestitur                                divis 
                                0.99                                 0.99 
                             dmarina                               dollar 
                                0.99                                 0.99 
                               donal                             donnelli 
                                0.99                                 0.99 
                            dorinson                                 doti 
                                0.99                                 0.99 
                                 dow                             downplay 
                                0.99                                 0.99 
                            downstat                            dportland 
                                0.99                                 0.99 
                                drag                                dread 
                                0.99                                 0.99 
                              driven                                 drop 
                                0.99                                 0.99 
                            dshafter                         dspringfield 
                                0.99                                 0.99 
                    dtoddftenergycom                            duluthbas 
                                0.99                                 0.99 
                                 dwr                                  dyn 
                                0.99                                 0.99 
                               earli                                  eas 
                                0.99                                 0.99 
                              easier                               easili 
                                0.99                                 0.99 
                             eastern                               eclips 
                                0.99                                 0.99 
                                econ                               ecotek 
                                0.99                                 0.99 
                              edison                               effect 
                                0.99                                 0.99 
                                 eix                         electricgrid 
                                0.99                                 0.99 
                    electricitygener                   electricitypurchas 
                                0.99                                 0.99 
                             element                           ellingwood 
                                0.99                                 0.99 
                               embed                                 emit 
                                0.99                                 0.99 
                             emshwil                               endors 
                                0.99                                 0.99 
                               endur                          energystarv 
                                0.99                                 0.99 
                          energytrad                              england 
                                0.99                                 0.99 
                              enmiti                                enorm 
                                0.99                                 0.99 
                               ensur                               entitl 
                                0.99                                 0.99 
                                 epg                                equal 
                                0.99                                 0.99 
                               equat                              equival 
                                0.99                                 0.99 
                              ernaut                                estim 
                                0.99                                 0.99 
                                even                               exceed 
                                0.99                                 0.99 
                               excus                            execution 
                                0.99                                 0.99 
                              exempt                               exodus 
                                0.99                                 0.99 
                              exoner                               expans 
                                0.99                                 0.99 
                              expect                           expenditur 
                                0.99                                 0.99 
                              expens                                expir 
                                0.99                                 0.99 
                              explan                              exploit 
                                0.99                                 0.99 
                               expos                               extend 
                                0.99                                 0.99 
                               facil                               factor 
                                0.99                                 0.99 
                                fail                                fairi 
                                0.99                                 0.99 
                             falloff                             familiar 
                                0.99                                 0.99 
                                 fan                              fashion 
                                0.99                                 0.99 
                             fastest                                fault 
                                0.99                                 0.99 
                               feder                                 feet 
                                0.99                                 0.99 
                           feinstein                             ferguson 
                                0.99                                 0.99 
                              ferret                              fichera 
                                0.99                                 0.99 
                               fierc                                 fill 
                                0.99                                 0.99 
                              financ                        finesalthough 
                                0.99                                 0.99 
                                fire                             fiveyear 
                                0.99                                 0.99 
                           fixedpric                                 flag 
                                0.99                                 0.99 
                                flat                              flexibl 
                                0.99                                 0.99 
                                 fli                               florez 
                                0.99                                 0.99 
                            fluctuat                                 flux 
                                0.99                                 0.99 
                                 foe                              fogarti 
                                0.99                                 0.99 
                               foley                                foray 
                                0.99                                 0.99 
                            forecast                              formula 
                                0.99                                 0.99 
                             founder                               fourth 
                                0.99                                 0.99 
                              fragil                         franciscobas 
                                0.99                                 0.99 
                              franck                                 fray 
                                0.99                                 0.99 
                                fred                                freed 
                                0.99                                 0.99 
                          freemarket                                freez 
                                0.99                                 0.99 
                              frenzi                             frequent 
                                0.99                                 0.99 
                            frustrat                                 fuel 
                                0.99                                 0.99 
                                full                                  gap 
                                0.99                                 0.99 
                                 gas                              gascost 
                                0.99                                 0.99 
                              gasfir                              gaudett 
                                0.99                                 0.99 
                                gaug                              general 
                                0.99                                 0.99 
                             generat                              georgia 
                                0.99                                 0.99 
                            geotherm                                gerth 
                                0.99                                 0.99 
                               glenn                                 goal 
                                0.99                                 0.99 
                             goliath                                  gov 
                                0.99                                 0.99 
                                gray                              greater 
                                0.99                                 0.99 
                                grew                                 grid 
                                0.99                                 0.99 
                            guarante                             guidelin 
                                0.99                                 0.99 
                               gyrat                           hagerstown 
                                0.99                                 0.99 
                       hagerstownbas                                  hal 
                                0.99                                 0.99 
                                half                              halfown 
                                0.99                                 0.99 
                              hammer                               hamper 
                                0.99                                 0.99 
                            harrigan                                harsh 
                                0.99                                 0.99 
                            hathaway                                hawig 
                                0.99                                 0.99 
                           headquart                            healthier 
                                0.99                                 0.99 
                                heat                              heavili 
                                0.99                                 0.99 
                              hebert                                hefti 
                                0.99                                 0.99 
                              height                                herik 
                                0.99                                 0.99 
                                high                              highest 
                                0.99                                 0.99 
                           highlight                             highpric 
                                0.99                                 0.99 
                                hike                                hinik 
                                0.99                                 0.99 
                              histor                                 hole 
                                0.99                                 0.99 
                            hopeless                              horribl 
                                0.99                                 0.99 
                              hospit                            household 
                                0.99                                 0.99 
                               howev                  httpwwwagostatemaus 
                                0.99                                 0.99 
             httpwwwalliantenergycom                     httpwwwcpuccagov 
                                0.99                                 0.99 
                     httpwwwisonecom                        httpwwwmgecom 
                                0.99                                 0.99 
               httpwwwnstaronlinecom                  httpwwwpscstatewius 
                                0.99                                 0.99 
                    httpwwwwiscuborg                  httpwwwwisenergycom 
                                0.99                                 0.99 
                               huard                                hundr 
                                0.99                                 0.99 
                          huntington                                hurri 
                                0.99                                 0.99 
                               hydro                          hydroelectr 
                                0.99                                 0.99 
                         hydroquebec                              ideolog 
                                0.99                                 0.99 
                               ignor                                  ill 
                                0.99                                 0.99 
                              illbas                              illinoi 
                                0.99                                 0.99 
                                imag                               immedi 
                                0.99                                 0.99 
                              immens                                immin 
                                0.99                                 0.99 
                              impair                               imperi 
                                0.99                                 0.99 
                               impos                               imposs 
                                0.99                                 0.99 
                               impot                             imprecis 
                                0.99                                 0.99 
                               inabl                              inaccur 
                                0.99                                 0.99 
                               inact                                  inc 
                                0.99                                 0.99 
                              incent                               incept 
                                0.99                                 0.99 
                               incid                               inclin 
                                0.99                                 0.99 
                           inconsist                               indebt 
                                0.99                                 0.99 
                            independ                                index 
                                0.99                                 0.99 
                           indispens                             ineffect 
                                0.99                                 0.99 
                              inevit                            influenti 
                                0.99                                 0.99 
                             infobox                            infograph 
                                0.99                                 0.99 
                              ingram                              inhibit 
                                0.99                                 0.99 
                              inject                              injunct 
                                0.99                                 0.99 
                             insofar                               insolv 
                                0.99                                 0.99 
                             instanc                            insuffici 
                                0.99                                 0.99 
                               insul                               intens 
                                0.99                                 0.99 
interactivecaliforniaimplicationsdoc     interactivecaliforniaselecteddoc 
                                0.99                                 0.99 
                        interconnect                               interf 
                                0.99                                 0.99 
                            interfac                       interjurisdict 
                                0.99                                 0.99 
                           interpret                            interrupt 
                                0.99                                 0.99 
                             interst                            intervent 
                                0.99                                 0.99 
                             intrast                             intrazon 
                                0.99                                 0.99 
                            introduc                          investorown 
                                0.99                                 0.99 
                         involuntari                               inward 
                                0.99                                 0.99 
                             iowabas                                 iron 
                                0.99                                 0.99 
                             irrepar                                jason 
                                0.99                                 0.99 
             jasonleopolddowjonescom                                jenif 
                                0.99                                 0.99 
                            jeopardi                               jersey 
                                0.99                                 0.99 
                      jerseymaryland                              jessica 
                                0.99                                 0.99 
          jessicabertholddowjonescom                               jockey 
                                0.99                                 0.99 
                              joliet                                 jone 
                                0.99                                 0.99 
                          journalist                                 judg 
                                0.99                                 0.99 
                                juic                               justic 
                                0.99                                 0.99 
                              justif                              justifi 
                                0.99                                 0.99 
                                kate                               keeley 
                                0.99                                 0.99 
                              keeper                                 kern 
                                0.99                                 0.99 
                              keynot                                  kid 
                                0.99                                 0.99 
                            kilowatt                         kilowatthour 
                                0.99                                 0.99 
                                king                                 kirk 
                                0.99                                 0.99 
                               knock                                 lack 
                                0.99                                 0.99 
                                laid                                 lake 
                                0.99                                 0.99 
                             lancast                             landmark 
                                0.99                                 0.99 
                           landsberg                                 laps 
                                0.99                                 0.99 
                             larcamp                                 larg 
                                0.99                                 0.99 
                              larger                              largest 
                                0.99                                 0.99 
                                 las                                 last 
                                0.99                                 0.99 
                           lastminut                               latest 
                                0.99                                 0.99 
                              lawmak                              lawrenc 
                                0.99                                 0.99 
                             lawsuit                               lawyer 
                                0.99                                 0.99 
                          legislatur                              legitim 
                                0.99                                 0.99 
                            leimgrub                             leitzing 
                                0.99                                 0.99 
                                lend                               length 
                                0.99                                 0.99 
                             lengthi                              leopold 
                                0.99                                 0.99 
                                less                               lessen 
                                0.99                                 0.99 
                             leverag                                 levi 
                                0.99                                 0.99 
                                 lie                            lightbulb 
                                0.99                                 0.99 
                              lightn                           likelihood 
                                0.99                                 0.99 
                               liken                                 line 
                                0.99                                 0.99 
                                load                             lobbyist 
                                0.99                                 0.99 
                          localfeder                               longer 
                                0.99                                 0.99 
                            longrang                             longterm 
                                0.99                                 0.99 
                                 los                                 loss 
                                0.99                                 0.99 
                                lott                                  low 
                                0.99                                 0.99 
                              lowest                                  ltd 
                                0.99                                 0.99 
                               lurch                                 made 
                                0.99                                 0.99 
                             madison                             magnitud 
                                0.99                                 0.99 
                                main                                major 
                                0.99                                 0.99 
                                make                            manhattan 
                                0.99                                 0.99 
                            manifest                              manipul 
                                0.99                                 0.99 
                                 map                             marathon 
                                0.99                                 0.99 
                              marcel                           markethedg 
                                0.99                                 0.99 
                           marketpow                     marketrestructur 
                                0.99                                 0.99 
                            maryland                                 mass 
                                0.99                                 0.99 
                        massachusett                               massiv 
                                0.99                                 0.99 
                         mattereveri                                mayor 
                                0.99                                 0.99 
                           mcelhenni                             meanwhil 
                                0.99                                 0.99 
                              mechan                                medic 
                                0.99                                 0.99 
                             mediums                             megawatt 
                                0.99                                 0.99 
                        megawatthour                             meltdown 
                                0.99                                 0.99 
                              merger                               merril 
                                0.99                                 0.99 
                               meter                                 meti 
                                0.99                                 0.99 
                                mges                              michaud 
                                0.99                                 0.99 
                         midamerican                 midamericancalenergi 
                                0.99                                 0.99 
                           midatlant                           midjanuari 
                                0.99                                 0.99 
                               midst                               midway 
                                0.99                                 0.99 
                        midwaysunset                              midwest 
                                0.99                                 0.99 
                              miguel                          millinocket 
                                0.99                                 0.99 
                             million                         milwaukeebas 
                                0.99                                 0.99 
                           minnesota                               mirror 
                                0.99                                 0.99 
                         misbehavior                             mismatch 
                                0.99                                 0.99 
                             mission                        mississippian 
                                0.99                                 0.99 
                              mistak                              mitchel 
                                0.99                                 0.99 
                               mitig                               modest 
                                0.99                                 0.99 
                              modifi                              monahan 
                                0.99                                 0.99 
                               money                                month 
                                0.99                                 0.99 
                              morain                           moratorium 
                                0.99                                 0.99 
                              morrel                               mosher 
                                0.99                                 0.99 
                              motion                                motiv 
                                0.99                                 0.99 
                               mount                             mountain 
                                0.99                                 0.99 
                        mountainview                             movement 
                                0.99                                 0.99 
                                much                              multipl 
                                0.99                                 0.99 
                            multipli                            multiyear 
                                0.99                                 0.99 
                             municip                                musel 
                                0.99                                 0.99 
                             mustrun                                  mwh 
                                0.99                                 0.99 
                                myer                                nasti 
                                0.99                                 0.99 
                           nationwid                                natur 
                                0.99                                 0.99 
                           naturalga                                 near 
                                0.99                                 0.99 
                        nearbankrupt                                  neb 
                                0.99                                 0.99 
                                need                             neighbor 
                                0.99                                 0.99 
                             network                                  nev 
                                0.99                                 0.99 
                              nevada                         nevertheless 
                                0.99                                 0.99 
                                 new                                newli 
                                0.99                                 0.99 
                             newswir                               nimock 
                                0.99                                 0.99 
      nimockshounorthamericamckinsey                                nizat 
                                0.99                                 0.99 
                              nobodi                                  non 
                                0.99                                 0.99 
                                none                               nonrmr 
                                0.99                                 0.99 
                           nontradit                               normal 
                                0.99                                 0.99 
                              norman                           northbrook 
                                0.99                                 0.99 
                           northeast                         northeastern 
                                0.99                                 0.99 
                           northwest                               notabl 
                                0.99                                 0.99 
                              notion                                  nrg 
                                0.99                                 0.99 
                               nstar                              nuclear 
                                0.99                                 0.99 
                               nyiso                                  oak 
                                0.99                                 0.99 
                              obscur                               observ 
                                0.99                                 0.99 
                              offici                               offlin 
                                0.99                                 0.99 
                             offshor                                 ohio 
                                0.99                                 0.99 
                                 oil                                 okla 
                                0.99                                 0.99 
                            oklahoma                            ombudsman 
                                0.99                                 0.99 
                                omin                                  one 
                                0.99                                 0.99 
                            onethird                              oneyear 
                                0.99                                 0.99 
                                ongo                                 onto 
                                0.99                                 0.99 
                                open                                 oper 
                                0.99                                 0.99 
                               oppos                              opposit 
                                0.99                                 0.99 
                                 ore                                 orga 
                                0.99                                 0.99 
                               outag                               outcom 
                                0.99                                 0.99 
                              outpac                               output 
                                0.99                                 0.99 
                            outright                               outsiz 
                                0.99                                 0.99 
                           overbuild                            overcharg 
                                0.99                                 0.99 
                              overdu                               overse 
                                0.99                                 0.99 
                                 own                               oyster 
                                0.99                                 0.99 
                                pace                                pacif 
                                0.99                                 0.99 
                                paid                                 pain 
                                0.99                                 0.99 
                                pale                             parallel 
                                0.99                                 0.99 
                             partial                             partylin 
                                0.99                                 0.99 
                            pasadena                                 pass 
                                0.99                                 0.99 
                              passiv                              patient 
                                0.99                                 0.99 
                                 pay                                payer 
                                0.99                                 0.99 
                             payment                                  pcg 
                                0.99                                 0.99 
                                peak                      pennsylvanianew 
                                0.99                                 0.99 
                             percent                               period 
                                0.99                                 0.99 
                             permiss                            petroleum 
                                0.99                                 0.99 
                                 pge                           phenomenon 
                                0.99                                 0.99 
                              picpcx                               pillar 
                                0.99                                 0.99 
                             pinnacl                               pitfal 
                                0.99                                 0.99 
                                 pjm                                 pjms 
                                0.99                                 0.99 
                               plagu                                 plan 
                                0.99                                 0.99 
                               plane                                plant 
                                0.99                                 0.99 
                                 plc                             pleasant 
                                0.99                                 0.99 
                              plenti                               plight 
                                0.99                                 0.99 
                                plow                                 plug 
                                0.99                                 0.99 
                              pocket                                pocta 
                                0.99                                 0.99 
                                pois                                 pole 
                                0.99                                 0.99 
                               polic                               pollut 
                                0.99                                 0.99 
                        pollutionrel                               polski 
                                0.99                                 0.99 
                                pool                                 pore 
                                0.99                                 0.99 
                             portion                                 pose 
                                0.99                                 0.99 
                             postpon                              potenti 
                                0.99                                 0.99 
                               pound                           powergener 
                                0.99                                 0.99 
                            powerget                               prairi 
                                0.99                                 0.99 
                               prais                                  pre 
                                0.99                                 0.99 
                              preced                            predatori 
                                0.99                                 0.99 
                         preliminari                               presum 
                                0.99                                 0.99 
                            pretextu                                  pri 
                                0.99                                 0.99 
                               price                         pricerespons 
                                0.99                                 0.99 
                         pricesensit                             principl 
                                0.99                                 0.99 
                       privatesector                                  pro 
                                0.99                                 0.99 
                               probe                               produc 
                                0.99                                 0.99 
                              profil                               profit 
                                0.99                                 0.99 
                             program                              prolong 
                                0.99                                 0.99 
                              promin                             pronounc 
                                0.99                                 0.99 
                               proof                              prophet 
                                0.99                                 0.99 
                              propos                                  pru 
                                0.99                                 0.99 
                                 psc                               public 
                                0.99                                 0.99 
                                pull                                 pump 
                                0.99                                 0.99 
                              punish                              purchas 
                                0.99                                 0.99 
                              purpos                             pursuant 
                                0.99                                 0.99 
                                push                                  pwr 
                                0.99                                 0.99 
                                 qfs                              qualifi 
                                0.99                                 0.99 
                             quarter                              questar 
                                0.99                                 0.99 
                             quicken                                quinn 
                                0.99                                 0.99 
                              quinta                                 rail 
                                0.99                                 0.99 
                             rainfal                                raini 
                                0.99                                 0.99 
                                rais                                  ram 
                                0.99                                 0.99 
                            randolph                                 rang 
                                0.99                                 0.99 
                                rare                                 rate 
                                0.99                                 0.99 
                             ratepay                               rattey 
                                0.99                                 0.99 
                                 raw                              realtim 
                                0.99                                 0.99 
                                ream                                 reap 
                                0.99                                 0.99 
                              reason                              reassur 
                                0.99                                 0.99 
                               rebat                                rebuf 
                                0.99                                 0.99 
                              recent                              reclaim 
                                0.99                                 0.99 
                            reconsid                              recruit 
                                0.99                                 0.99 
                                 red                             redesign 
                                0.99                                 0.99 
                             reflect                               refund 
                                0.99                                 0.99 
                          regardless                               region 
                                0.99                                 0.99 
                                 rei                               reilli 
                                0.99                                 0.99 
                            reimburs                                 rein 
                                0.99                                 0.99 
                           reiterman                                relax 
                                0.99                                 0.99 
                          relentless                              relianc 
                                0.99                                 0.99 
                             reliant                               reliev 
                                0.99                                 0.99 
                              remedi                                renew 
                                0.99                                 0.99 
                             renobas                               repaid 
                                0.99                                 0.99 
                              repair                                repay 
                                0.99                                 0.99 
                              repeal                            repercuss 
                                0.99                                 0.99 
                              replac                               replic 
                                0.99                                 0.99 
                              requir                               reserv 
                                0.99                                 0.99 
                              resold                              resourc 
                                0.99                                 0.99 
                            restrain                               result 
                                0.99                                 0.99 
                              revenu                               reward 
                                0.99                                 0.99 
                                 rey                               rhanov 
                                0.99                                 0.99 
                              rhetor                               ribbon 
                                0.99                                 0.99 
                           ridgewood                                 rife 
                                0.99                                 0.99 
                                rise                                risen 
                                0.99                                 0.99 
                           riskavers                                riski 
                                0.99                                 0.99 
                            riversid                         rjacksonvill 
                                0.99                                 0.99 
                                 rla                             rlancast 
                                0.99                                 0.99 
                                 rmr                             robinson 
                                0.99                                 0.99 
                                rock                               rocket 
                                0.99                                 0.99 
                               rocki                                 roil 
                                0.99                                 0.99 
                                rone                            roosevelt 
                                0.99                                 0.99 
                                root                                 rose 
                                0.99                                 0.99 
                            rosemead                                rough 
                                0.99                                 0.99 
                               rreno                                 rule 
                                0.99                                 0.99 
                             runaway                               runner 
                                0.99                                 0.99 
                               runup                                saber 
                                0.99                                 0.99 
                       sacramentobas                                 said 
                                0.99                                 0.99 
                                sale                                salem 
                                0.99                                 0.99 
                                salt                                savag 
                                0.99                                 0.99 
                                save                                 saxl 
                                0.99                                 0.99 
                                 say                             scenario 
                                0.99                                 0.99 
                          schoenherr                               school 
                                0.99                                 0.99 
                                scof                              scrambl 
                                0.99                                 0.99 
                            scrutini                        secondlargest 
                                0.99                                 0.99 
                             secreci                              section 
                                0.99                                 0.99 
                                seek                              segundo 
                                0.99                                 0.99 
                                sell                               sempra 
                                0.99                                 0.99 
                               separ                                  set 
                                0.99                                 0.99 
                               seven                                sever 
                                0.99                                 0.99 
                             severin                            sharehold 
                                0.99                                 0.99 
                            sheffrin                                shelv 
                                0.99                                 0.99 
                            sheppard                                shift 
                                0.99                                 0.99 
                            shipment                              shipper 
                                0.99                                 0.99 
                               shock                              shortag 
                                0.99                                 0.99 
                             shorten                             shortfal 
                                0.99                                 0.99 
                                shot                                 show 
                                0.99                                 0.99 
                              shrink                               shrunk 
                                0.99                                 0.99 
                                shut                             shutdown 
                                0.99                                 0.99 
                              sierra                                 sign 
                                0.99                                 0.99 
                              signal                              similar 
                                0.99                                 0.99 
                               simpl                               simpli 
                                0.99                                 0.99 
                            simultan                                 sinc 
                                0.99                                 0.99 
                                site                             sixmonth 
                                0.99                                 0.99 
                                size                              skeptic 
                                0.99                                 0.99 
                              skygen                                slack 
                                0.99                                 0.99 
                               slate                               slight 
                                0.99                                 0.99 
                                slip                               sloppi 
                                0.99                                 0.99 
                              slower                                small 
                                0.99                                 0.99 
                           smallbusi                             smallest 
                                0.99                                 0.99 
                             smarter                                 smog 
                                0.99                                 0.99 
                              smooth                                 soar 
                                0.99                                 0.99 
                               socal                              softped 
                                0.99                                 0.99 
                               sokol                                solar 
                                0.99                                 0.99 
                                sold                                 solv 
                                0.99                                 0.99 
                             solvenc                              sophist 
                                0.99                                 0.99 
                            sorensen                                south 
                                0.99                                 0.99 
                            southern                            southland 
                                0.99                                 0.99 
                                spar                           specialist 
                                0.99                                 0.99 
                             specifi                              specter 
                                0.99                                 0.99 
                              specul                              spencer 
                                0.99                                 0.99 
                               spent                                spike 
                                0.99                                 0.99 
                              spiral                            spokesman 
                                0.99                                 0.99 
                           spokesmen                          spokeswoman 
                                0.99                                 0.99 
                          spotmarket                               spring 
                                0.99                                 0.99 
                                spur                                  sre 
                                0.99                                 0.99 
                             stagger                                stall 
                                0.99                                 0.99 
                            standard                                state 
                                0.99                                 0.99 
                        stateappoint                              station 
                                0.99                                 0.99 
                             statist                                stave 
                                0.99                                 0.99 
                            steadili                                steam 
                                0.99                                 0.99 
                               steep                              steepli 
                                0.99                                 0.99 
                                stem                              stengel 
                                0.99                                 0.99 
                               stern                                stick 
                                0.99                                 0.99 
                               stifl                                 stop 
                                0.99                                 0.99 
                              storag                               strain 
                                0.99                                 0.99 
                              stride                                strip 
                                0.99                                 0.99 
                             struggl                                stunt 
                                0.99                                 0.99 
                             subsidi                           subsidiari 
                                0.99                                 0.99 
                           substanti                               suffer 
                                0.99                                 0.99 
                             suffici                               summar 
                                0.99                                 0.99 
                           summerlik                               summit 
                                0.99                                 0.99 
                              sunset                             superior 
                                0.99                                 0.99 
                            supplier                               surgic 
                                0.99                                 0.99 
                             surplus                             surround 
                                0.99                                 0.99 
                             suspend                            suspicion 
                                0.99                                 0.99 
                             sustain                               suzann 
                                0.99                                 0.99 
           suzannenimocksmckinseycom                              swelter 
                                0.99                                 0.99 
                              switch                              sympath 
                                0.99                                 0.99 
                              system                                  tab 
                                0.99                                 0.99 
                              tailor                               tamaki 
                                0.99                                 0.99 
                                 tap                                taper 
                                0.99                                 0.99 
                              taxpay                                  tem 
                                0.99                                 0.99 
                          temperatur                              tempest 
                                0.99                                 0.99 
                           temporari                          temporarili 
                                0.99                                 0.99 
                                tend                              tenuous 
                                0.99                                 0.99 
                                 tep                              testifi 
                                0.99                                 0.99 
                           testimoni                                therm 
                                0.99                                 0.99 
                             thermal                               thermo 
                                0.99                                 0.99 
                               third                               thorni 
                                0.99                                 0.99 
                           threshold                             thursday 
                                0.99                                 0.99 
                                 tie                                 time 
                                0.99                                 0.99 
                          timeconsum                                 tini 
                                0.99                                 0.99 
                              togeth                                token 
                                0.99                                 0.99 
                                toll                                 tool 
                                0.99                                 0.99 
                            townsend                                trace 
                                0.99                                 0.99 
                               trade                          transenergi 
                                0.99                                 0.99 
                            translat                             transmit 
                                0.99                                 0.99 
                          transplant                                tread 
                                0.99                                 0.99 
                             treasur                                trend 
                                0.99                                 0.99 
                               trent                                 trim 
                                0.99                                 0.99 
                                tuck                                tulsa 
                                0.99                                 0.99 
                            tulsabas                              turmoil 
                                0.99                                 0.99 
                               twice                                  two 
                                0.99                                 0.99 
                            twothird                                typic 
                                0.99                                 0.99 
                               ultim                              unavail 
                                0.99                                 0.99 
                           uncertain                            uncollect 
                                0.99                                 0.99 
                        undercollect                           underestim 
                                0.99                                 0.99 
                           underscor                             underwat 
                                0.99                                 0.99 
                             undesir                                 undo 
                                0.99                                 0.99 
                                undu                               unfair 
                                0.99                                 0.99 
                              unfett                                unfil 
                                0.99                                 0.99 
                          unforeseen                              uniform 
                                0.99                                 0.99 
                            unintend                                union 
                                0.99                                 0.99 
                               unlaw                                unlik 
                                0.99                                 0.99 
                              unpaid                             unpreced 
                                0.99                                 0.99 
                             unregul                             unseason 
                                0.99                                 0.99 
                              unwarr                                upset 
                                0.99                                 0.99 
                              upstat                               upward 
                                0.99                                 0.99 
                                utah                                 util 
                                0.99                                 0.99 
                      utilitiespacif                         utilitiessan 
                                0.99                                 0.99 
                     utilitiesstrenu                       utilityderegul 
                                0.99                                 0.99 
                              valley                                  van 
                                0.99                                 0.99 
                              vanech                              variabl 
                                0.99                                 0.99 
                             varieti                              various 
                                0.99                                 0.99 
                                vast                             vegasbas 
                                0.99                                 0.99 
                            vehement                        venkateshwara 
                                0.99                                 0.99 
                               venki                             verbatim 
                                0.99                                 0.99 
                                verg                              veteran 
                                0.99                                 0.99 
                             victori                                vigor 
                                0.99                                 0.99 
                              vikram                         villaraigosa 
                                0.99                                 0.99 
                              violat                             virginia 
                                0.99                                 0.99 
                               virtu                                vocal 
                                0.99                                 0.99 
                               vogel                              volatil 
                                0.99                                 0.99 
                              voltag                                volum 
                                0.99                                 0.99 
                              vulner                                wagon 
                                0.99                                 0.99 
                                wake                                walli 
                                0.99                                 0.99 
                                warn                              warrant 
                                0.99                                 0.99 
                              warren                                 weak 
                                0.99                                 0.99 
                           wednesday                        weeklysometim 
                                0.99                                 0.99 
                           wellequip                             wellhead 
                                0.99                                 0.99 
                              whenev                               wherea 
                                0.99                                 0.99 
                             whether                             whitewat 
                                0.99                                 0.99 
                          wholeheart                                widen 
                                0.99                                 0.99 
                            widerang                                 wild 
                                0.99                                 0.99 
                           wilkerson                                 will 
                                0.99                                 0.99 
                             william                              windfal 
                                0.99                                 0.99 
                              winter                               winwin 
                                0.99                                 0.99 
                           wisconsin                              wisvest 
                                0.99                                 0.99 
                                 wit                               within 
                                0.99                                 0.99 
                                 wmb                                 wood 
                                0.99                                 0.99 
                               worri                                 wors 
                                0.99                                 0.99 
                              worsen                               writer 
                                0.99                                 0.99 
                             wrongdo                     wwwlatimescompow 
                                0.99                                 0.99 
                                wyom                                 year 
                                0.99                                 0.99 
                             yearend                               yorker 
                                0.99                                 0.99 
                                zero                              ziegler 
                                0.99                                 0.99 
                                abus                               accord 
                                0.98                                 0.98 
                                 act                            agreement 
                                0.98                                 0.98 
                            although                                among 
                                0.98                                 0.98 
                              amount                                april 
                                0.98                                 0.98 
                               avoid                                 basi 
                                0.98                                 0.98 
                               beach                                began 
                                0.98                                 0.98 
                                 bid                                  big 
                                0.98                                 0.98 
                               build                                  buy 
                                0.98                                 0.98 
                               capac                                claim 
                                0.98                                 0.98 
                            competit                            construct 
                                0.98                                 0.98 
                            contract                            contribut 
                                0.98                                 0.98 
                               court                               critic 
                                0.98                                 0.98 
                                debt                               decemb 
                                0.98                                 0.98 
                               decis                               declin 
                                0.98                                 0.98 
                              differ                                 done 
                                0.98                                 0.98 
                                 due                                 edit 
                                0.98                                 0.98 
                               emerg                              environ 
                                0.98                                 0.98 
                              examin                              exchang 
                                0.98                                 0.98 
                              execut                                  far 
                                0.98                                 0.98 
                            februari                                 file 
                                0.98                                 0.98 
                               first                                 five 
                                0.98                                 0.98 
                               focus                               foster 
                                0.98                                 0.98 
                               fulli                                 give 
                                0.98                                 0.98 
                                hand                                  hot 
                                0.98                                 0.98 
                                hour                                 huge 
                                0.98                                 0.98 
                              impact                               import 
                                0.98                                 0.98 
                            industri                                 issu 
                                0.98                                 0.98 
                             januari                                 keep 
                                0.98                                 0.98 
                               known                                  law 
                                0.98                                 0.98 
                                lose                                  lot 
                                0.98                                 0.98 
                               lower                                 mani 
                                0.98                                 0.98 
                               march                               margin 
                                0.98                                 0.98 
                          marketplac                                  may 
                                0.98                                 0.98 
                              measur                           memorandum 
                                0.98                                 0.98 
                              miller                              monitor 
                                0.98                                 0.98 
                                must                               negoti 
                                0.98                                 0.98 
                              novemb                                often 
                                0.98                                 0.98 
                                 owe                                owner 
                                0.98                                 0.98 
                                part                                parti 
                                0.98                                 0.98 
                                paso                              possibl 
                                0.98                                 0.98 
                             problem                              process 
                                0.98                                 0.98 
                              promis                               prompt 
                                0.98                                 0.98 
                                 puc                                refus 
                                0.98                                 0.98 
                          regulatori                                relat 
                                0.98                                 0.98 
                              repres                              request 
                                0.98                                 0.98 
                               right                                  run 
                                0.98                                 0.98 
                             serious                               servic 
                                0.98                                 0.98 
                            signific                               situat 
                                0.98                                 0.98 
                               sourc                                 spot 
                                0.98                                 0.98 
                              stabil                                staff 
                                0.98                                 0.98 
                               still                              suggest 
                                0.98                                 0.98 
                          supervisor                               though 
                                0.98                                 0.98 
                                took                                total 
                                0.98                                 0.98 
                              toward                             transact 
                                0.98                                 0.98 
                              troubl                                 unit 
                                0.98                                 0.98 
                                 use                                 want 
                                0.98                                 0.98 
                               water                              western 
                                0.98                                 0.98 
                             without                                  yet 
                                0.98                                 0.98 
                                york                              acceler 
                                0.98                                 0.97 
                              actual                            administr 
                                0.97                                 0.97 
                                agre                                ahead 
                                0.97                                 0.97 
                              almost                              alreadi 
                                0.97                                 0.97 
                              appeal                               applic 
                                0.97                                 0.97 
                              associ                                audit 
                                0.97                                 0.97 
                                base                               calpin 
                                0.97                                 0.97 
                                came                                  can 
                                0.97                                 0.97 
                                case                               center 
                                0.97                                 0.97 
                             certain                              commerc 
                                0.97                                 0.97 
                             conclud                           constraint 
                                0.97                                 0.97 
                             consult                              correct 
                                0.97                                 0.97 
                               cover                                 deal 
                                0.97                                 0.97 
                               decad                               declar 
                                0.97                                 0.97 
                            determin                              economi 
                                0.97                                 0.97 
                              effici                               effort 
                                0.97                                 0.97 
                              employ                                enter 
                                0.97                                 0.97 
                               everi                               excess 
                                0.97                                 0.97 
                              expand                              express 
                                0.97                                 0.97 
                                face                                 fall 
                                0.97                                 0.97 
                               figur                              financi 
                                0.97                                 0.97 
                                flaw                                  fpa 
                                0.97                                 0.97 
                                home                               implic 
                                0.97                                 0.97 
                               insid                              instead 
                                0.97                                 0.97 
                            interest                                 lead 
                                0.97                                 0.97 
                                like                                might 
                                0.97                                 0.97 
                              monday                             monopoli 
                                0.97                                 0.97 
                                 net                                 news 
                                0.97                                 0.97 
                                next                              nonpubl 
                                0.97                                 0.97 
                              oregon                               overal 
                                0.97                                 0.97 
                                 per                              pipelin 
                                0.97                                 0.97 
                               posit                              practic 
                                0.97                                 0.97 
                              privat                             properti 
                                0.97                                 0.97 
                               prove                              qualiti 
                                0.97                                 0.97 
                               refer                               remain 
                                0.97                                 0.97 
                               resid                                 rest 
                                0.97                                 0.97 
                               share                               sought 
                                0.97                                 0.97 
                              submit                             threaten 
                                0.97                                 0.97 
                                thus                                 told 
                                0.97                                 0.97 
                                 tri                              twoyear 
                                0.97                                 0.97 
                                user                                  way 
                                0.97                                 0.97 
                                 won                               across 
                                0.97                                 0.96 
                             address                            ancillari 
                                0.96                                 0.96 
                                away                                begin 
                                0.96                                 0.96 
                              behind                               breath 
                                0.96                                 0.96 
                               bring                                buyer 
                                0.96                                 0.96 
                                call                                 ceil 
                                0.96                                 0.96 
                               chang                                clear 
                                0.96                                 0.96 
                             collect                              complet 
                                0.96                                 0.96 
                             complex                            condition 
                                0.96                                 0.96 
                             consequ                              coordin 
                                0.96                                 0.96 
                                corp                               direct 
                                0.96                                 0.96 
                            director                                 duti 
                                0.96                                 0.96 
                             earlier                                emiss 
                                0.96                                 0.96 
                                form                                futur 
                                0.96                                 0.96 
                                 get                                given 
                                0.96                                 0.96 
                                hard                                  hit 
                                0.96                                 0.96 
                            identifi                                illeg 
                                0.96                                 0.96 
                       infrastructur                              inquiri 
                                0.96                                 0.96 
                                just                                 late 
                                0.96                                 0.96 
                               later                                 long 
                                0.96                                 0.96 
                              matter                                 mean 
                                0.96                                 0.96 
                         necessarili                             northern 
                                0.96                                 0.96 
                            procedur                               procur 
                                0.96                                 0.96 
                                 put                               receiv 
                                0.96                                 0.96 
                             respect                              respons 
                                0.96                                 0.96 
                                rush                                  see 
                                0.96                                 0.96 
                               solut                               someth 
                                0.96                                 0.96 
                              spread                                stage 
                                0.96                                 0.96 
                               stand                               tariff 
                                0.96                                 0.96 
                                text                             therefor 
                                0.96                                 0.96 
                               tight                                  top 
                                0.96                                 0.96 
                              trader                              tuesday 
                                0.96                                 0.96 
                                turn                               unless 
                                0.96                                 0.96 
                            withhold                                worth 
                                0.96                                 0.96 
                                 ago                                anoth 
                                0.95                                 0.95 
                              articl                               author 
                                0.95                                 0.95 
                         californian                             consider 
                                0.95                                 0.95 
                               daili                                 data 
                                0.95                                 0.95 
                             describ                              develop 
                                0.95                                 0.95 
                                 end                            experienc 
                                0.95                                 0.95 
                              happen                               inform 
                                0.95                                 0.95 
                              intern                            interview 
                                0.95                                 0.95 
                              joseph                                 kept 
                                0.95                                 0.95 
                           marketbas                                offer 
                                0.95                                 0.95 
                               panel                              proceed 
                                0.95                                 0.95 
                             product                              project 
                                0.95                                 0.95 
                          republican                              sometim 
                                0.95                                 0.95 
                               spend                            statement 
                                0.95                                 0.95 
                                texa                                track 
                                0.95                                 0.95 
                           transport                                 wall 
                                0.95                                 0.95 
                                week                                 west 
                                0.95                                 0.95 
                              afford                                alloc 
                                0.94                                 0.94 
                               along                               appear 
                                0.94                                 0.94 
                            approach                               assess 
                                0.94                                 0.94 
                              burden                               calcul 
                                0.94                                 0.94 
                                cash                                civil 
                                0.94                                 0.94 
                                club                                 coal 
                                0.94                                 0.94 
                              compar                              compens 
                                0.94                                 0.94 
                         connecticut                              definit 
                                0.94                                 0.94 
                                easi                                entir 
                                0.94                                 0.94 
                              entiti                               eventu 
                                0.94                                 0.94 
                                find                               former 
                                0.94                                 0.94 
                                free                                georg 
                                0.94                                 0.94 
                              insist                             investor 
                                0.94                                 0.94 
                                 jay                                labor 
                                0.94                                 0.94 
                              launch                                  llc 
                                0.94                                 0.94 
                              manner                                 mile 
                                0.94                                 0.94 
                               night                                occur 
                                0.94                                 0.94 
                               onlin                               parent 
                                0.94                                 0.94 
                                pend                                peopl 
                                0.94                                 0.94 
                             persuad                                point 
                                0.94                                 0.94 
                               polit                           politician 
                                0.94                                 0.94 
                           portfolio                             previous 
                                0.94                                 0.94 
                               print                             progress 
                                0.94                                 0.94 
                            question                             retroact 
                                0.94                                 0.94 
                               settl                                sharp 
                                0.94                                 0.94 
                               short                                 side 
                                0.94                                 0.94 
                               split                               strict 
                                0.94                                 0.94 
                              suppos                              suspect 
                                0.94                                 0.94 
                               swept                                 take 
                                0.94                                 0.94 
                                term                            transform 
                                0.94                                 0.94 
                                wind                                 work 
                                0.94                                 0.94 
                                abil                                asset 
                                0.93                                 0.93 
                             brought                               compet 
                                0.93                                 0.93 
                             default                                deliv 
                                0.93                                 0.93 
                            elsewher                               especi 
                                0.93                                 0.93 
                               exact                                  fix 
                                0.93                                 0.93 
                             foundat                             individu 
                                0.93                                 0.93 
                            influenc                               island 
                                0.93                                 0.93 
                                 jan                               legisl 
                                0.93                                 0.93 
                               light                                limit 
                                0.93                                 0.93 
                            maintain                            nonprofit 
                                0.93                                 0.93 
                                note                              partner 
                                0.93                                 0.93 
                             primari                               reform 
                                0.93                                 0.93 
                                role                                secur 
                                0.93                                 0.93 
                                 sen                                taken 
                                0.93                                 0.93 
                               today                                  ann 
                                0.93                                 0.92 
                               becam                                 bill 
                                0.92                                 0.92 
                                bush                                  cap 
                                0.92                                 0.92 
                             comment                               detail 
                                0.92                                 0.92 
                           difficult                                 fair 
                                0.92                                 0.92 
                                 fee                             institut 
                                0.92                                 0.92 
                              involv                                  iso 
                                0.92                                 0.92 
                               local                                  met 
                                0.92                                 0.92 
                                move                               number 
                                0.92                                 0.92 
                                past                                place 
                                0.92                                 0.92 
                              presid                              publish 
                                0.92                                 0.92 
                           recommend                               record 
                                0.92                                 0.92 
                              specif                                  tax 
                                0.92                                 0.92 
                                well                                allen 
                                0.92                                 0.91 
                              believ                               commod 
                                0.91                                 0.91 
                           communiti                                  dan 
                                0.91                                 0.91 
                           disclosur                             encourag 
                                0.91                                 0.91 
                               error                                 evid 
                                0.91                                 0.91 
                                ferc                               global 
                                0.91                                 0.91 
                                gone                                initi 
                                0.91                                 0.91 
                               legal                                lynch 
                                0.91                                 0.91 
                              materi                              meantim 
                                0.91                                 0.91 
                              review                                  sat 
                                0.91                                 0.91 
                                soon                                sound 
                                0.91                                 0.91 
                               start                                 talk 
                                0.91                                 0.91 
                               truth                           washington 
                                0.91                                 0.91 
                             announc                              attempt 
                                0.90                                 0.90 
                              commit                              concern 
                                0.90                                 0.90 
                                deni                               enforc 
                                0.90                                 0.90 
                             expedit                               extens 
                                0.90                                 0.90 
                                hold                               morgan 
                                0.90                                 0.90 
                               other                              prevent 
                                0.90                                 0.90 
                              provis                             reaction 
                                0.90                                 0.90 
                               reduc                              schedul 
                                0.90                                 0.90 
                                stay                               street 
                                0.90                                 0.90 
                               unabl 
                                0.90 
```


What Else Might You Do?
====================================================================================

* Use the `tidytext` package to work in a "tidy" way
* Make more visualizations of word frequencies or relationships in `ggplot2`
* Use hierarchical clustering to group together terms
* Fit topic models to find overarching topics
* Use `NLP` package to find bigrams (two-word phrases)
* Use `qdap` or `tidytext` packages to classify document sentiment (positive, negative) and look for relationships

Note: Before doing research with scraped data or social media data,
*make sure you are legally permitted to do so*. Some networks (e.g. *Nextdoor*), 
specifically ban collecting or analyzing data. Almost all websites will eventually
block you if you scrape *lots* of data.


Getting Serious with Text Mining
====================================================================================

I've introduced you to some basic text mining approaches.

If you want to *get serious* with text mining using modern techniques and "tidy" coding,
I suggest you look into the recently released [Text Mining with R](http://http://tidytextmining.com/),
written by the authors of the `tidytext` package.

Like *R for Data Science* and *Advanced R*, *Text Mining with R* is a free online textbook
(available in print also) that uses modern approaches to R coding to perform analyses
on real world data.


