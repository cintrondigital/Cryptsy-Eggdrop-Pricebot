# Cryptsy-Eggdrop-Pricebot
This bot was discovered on Egghelp.
The code was outdated and needed additional trading pairs.
The MTGox portion of the code was removed in this version.
I've already added 27 additional trading pairs.
I will continue to push updates and most likely will add more features to it.

<bold>Installation</bold>:

Upload the .tcl file to the scripts folder
<br>
Add the following entry to you eggdrop.conf or simple.conf:
<pre>source scripts/pricebot.tcl</pre>

To see the bot in action, visit:
http://manhattanmine.com/irc

<bold>Current Command List</bold>
<pre>
!btc     -BTC/USD Price     -added           
!drk     -DRK/BTC Price     -added            
!doge    -DOGE/BTC Price              
!ltc     -LTC/BTC Price                
!wdc     -WDC/BTC Price              
!tips    -TIPS/LTC Price               
!dgc     -DGC/BTC Price
!eac     -EAC/BTC Price
!lyc     -LYC/BTC Price     -added
!xrp     -XRP/BTC Price     -added
!xpy     -XPY/BTC Price     -added
!bitb    -BITB/BTC Price    -added
!dgb     -DGB/BTC Price     -added
!btcd    -BTCD/BTC Price    -added
!vrc     -VRC/BTC Price     -added
!sys     -SYS/BTC Price     -added
!pot     -POT/BTC Price     -added
!opal    -OPAL/BTC Price    -added
!net     -NET/BTC Price     -added
!nobl    -NOBL/BTC Price    -added
!mec     -MEC/BTC Price     -added
!mzc     -MZC/BTC Price     -added
!hyp     -HYP/BTC Price     -added
!hbn     -HBN/BTC Price     -added
!fibre   -FIBRE/BTC Price   -added
!emd     -EMD/BTC Price     -added
!clam    -CLAM/BTC Price    -added
!ccn     -CCN/BTC Price     -added
!cann    -CANN/BTC Price    -added
!blu     -BLU/BTC Price     -added
!bet     -BET/BTC Price     -added
!ari     -ARI/BTC Price     -added
!42      -42/BTC Price      -added
</pre>

Snippet of code to rewrite:
<pre>
bind pub - !btc get_bitcoin
proc get_bitcoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=2]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :BTC/USD price on Cryptsy: $thisvar"

}
</pre>
WhiskeyFund Address Btc: 138dzurFuavqyytobDTeMhSj2gh48uadcs


