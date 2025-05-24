# 🕹️ Steam Playtime Tracker

Shell scripts to track and summarize playtime for any game, including non-Steam games launched with Proton, using Steam’s Launch Options.



# 📁 Files

    playtime.sh
  Tracks how long a specified process runs, and logs playtime per session.

    sum_playtime.sh
  Summarizes total playtime for all logged games and writes the results to summary.log.

    summary.log 
  Contains each games total playtime as was well as the total for all games.


Game Logs Sample output (eg. ~/.local/share/game-playtime/Dark Souls III.log) : 

    [Fri May 23 03:13:28 PM EDT 2025] Ended Dark Souls 3. Duration: 0h 0m 7s
    [Fri May 23 15:14:38 EDT 2025] Ended Dark Souls 3. Duration: 0h 0m 13s
    [Fri May 23 15:16:02 EDT 2025] Ended Dark Souls 3. Duration: 0h 15m 48s


    

# 🔧 Setup

Place both scripts somewhere executable, e.g.:

    mkdir -p ~/scripts
    cp playtime.sh sum_playtime.sh ~/scripts/
    chmod +x ~/scripts/*.sh

Ensure logs are saved to:

    ~/.local/share/game-playtime/

# 🕹️ Tracking a Game

In Steam, add a game or edit a non-Steam game's Launch Options:

    /home/youruser/scripts/playtime.sh "Game Name" "Process Name" & %command%

Replace "Game Name" with a name you want in the log (e.g. Risk of Rain 2)

Replace "Process Name" with the actual process to track (e.g. RoR2.x86_64 or proton)

    %command% ensures Steam launches the game after starting the tracker

# 📊 Summarizing Playtime

Run the summary script to total up playtime per game:

    ~/scripts/sum_playtime.sh

This creates:

    ~/.local/share/game-playtime/summary.log

Sample contents:

    Risk of Rain 2               1h 42m 11s
    Dark Souls III               3h 10m  7s

    TOTAL                        4h 52m 18s

# 💡 Tips

You can reuse playtime.sh for each game by customizing the Launch Options

Works great with Proton-based games or any Linux binary

Put sum_playtime.sh into your global scripts directory or add an alias to run it 

Add alias to easily show game playtime log : 

    ~/scripts/sum_playtime.sh && bat ~/.local/share/game-playtime/summary.log
