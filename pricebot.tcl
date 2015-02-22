#########################################################################################
# Cryptocurrency Price Listing Bot. A modified version of erasei's bitcoin script       #
# (in fact it has the same functionality intact as well as other features the other     #
# features) which was n turn based off code written by pitbull.                         #
# This iteration made by withnail.                                                      #
#########################################################################################
# Modified by cintrondigital - Donation Address Btc: 138dzurFuavqyytobDTeMhSj2gh48uadcs #
# I added 27 Additional Markets and will continue to add more                           #
#########################################################################################

package require http
package require tls
http::register https 443 [list ::tls::socket -require 0 -request 1]

proc s:wget { url } {
   http::config -useragent "Mozilla/EggdropWget"
   catch {set token [http::geturl $url -binary 1 -timeout 10000]} error
   if {![string match -nocase "::http::*" $error]} {
      putserv "PRIVMSG $chan: Error: [string totitle [string map {"\n" " | "} $error]] \( $url \)"
      s:debug "Error: [string totitle [string map {"\n" " | "} $error]] \( $url \)"
      return 0
   }
   if {![string equal -nocase [::http::status $token] "ok"]} {
      putserv "PRIVMSG $chan: Http error: [string totitle [::http::status $token]] \( $url \)"
      s:debug "Http error: [string totitle [::http::status $token]] \( $url \)"
      http::cleanup $token
      return 0
   }
   if {[string match "*[http::ncode $token]*" "303|302|301" ]} {
      upvar #0 $token state
      foreach {name value} $state(meta) {
         if {[regexp -nocase ^location$ $name]} {
            if {![string match "http*" $value]} {
               if {![string match "/" [string index $value 0]]} {
                  set value "[join [lrange [split $url "/"] 0 2] "/"]/$value"
               } else {
                  set value "[join [lrange [split $url "/"] 0 2] "/"]$value"
               }
            }
            s:wget $value
            return
         }
      }
   }
   if {[string match 4* [http::ncode $token]] || [string match 5* [http::ncode $token]]} {
      putserv "PRIVMSG $chan: Http resource is not evailable: [http::ncode $token] \( $url \)"
      s:debug "Http resource is not evailable: [http::ncode $token] \( $url \)"
      return 0
   }
    set data [http::data $token]
    http::cleanup $token
    return $data
}


bind pub - !btcd get_bitcoindark
proc get_bitcoindark {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=256]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :BTCD/BTC price on Cryptsy: $thisvar"

}

bind pub - !vrc get_vericoin
proc get_vericoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=209]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :VRC/BTC price on Cryptsy: $thisvar"

}

bind pub - !sys get_syscoin
proc get_syscoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=278]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :SYS/BTC price on Cryptsy: $thisvar"

}

bind pub - !pot get_potcoin
proc get_potcoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=173]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :POT/BTC price on Cryptsy: $thisvar"

}

bind pub - !opal get_opal
proc get_opal {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=310]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :OPAL/BTC price on Cryptsy: $thisvar"

}

bind pub - !net get_netcoin
proc get_netcoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=134]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :NET/BTC price on Cryptsy: $thisvar"

}

bind pub - !nobl get_noblecoin
proc get_noblecoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=264]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :NOBL/BTC price on Cryptsy: $thisvar"

}

bind pub - !mec get_megacoin
proc get_megacoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=45]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :MEC/BTC price on Cryptsy: $thisvar"

}

bind pub - !mzc get_mazacoin
proc get_mazacoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=164]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :MZC/BTC price on Cryptsy: $thisvar"

}

bind pub - !hyp get_hyperstake
proc get_hyerstake {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=445]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :HYP/BTC price on Cryptsy: $thisvar"

}

bind pub - !btc get_hobonickels
proc get_hobonickels {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=80]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :HBN/BTC price on Cryptsy: $thisvar"

}

bind pub - !fibre get_fibre
proc get_fibre {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=301]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :FIBRE/BTC price on Cryptsy: $thisvar"

}

bind pub - !emd get_emerald
proc get_emerald {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=69]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :EMD/BTC price on Cryptsy: $thisvar"

}

bind pub - !clam get_clam
proc get_clam {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=462]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :CLAM/BTC price on Cryptsy: $thisvar"

}

bind pub - !ccn get_cannacoin
proc get_cannacoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=463]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :CCN/BTC price on Cryptsy: $thisvar"

}

bind pub - !cann get_cannabiscoin
proc get_cannabiscoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=300]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :CANN/BTC price on Cryptsy: $thisvar"

}

bind pub - !blu get_bluecoin
proc get_bluecoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=251]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :BLU/BTC price on Cryptsy: $thisvar"

}

bind pub - !bet get_betacoin
proc get_betacoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=129]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :BET/BTC price on Cryptsy: $thisvar"

}

bind pub - !ari get_aricoin
proc get_aricoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=471]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :ARI/BTC price on Cryptsy: $thisvar"

}

bind pub - !42 get_42coin
proc get_42coin {nick uhost handle chan arg} {
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
   putserv "PRIVMSG $chan :42/BTC price on Cryptsy: $thisvar"

}

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


bind pub - !lyc get_lycancoin
proc get_lycancoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=177]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :LYC/BTC price on Cryptsy: $thisvar"

}


bind pub - !xpy get_paycoin
proc get_paycoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=466]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :XPY/BTC price on Cryptsy: $thisvar"

}


bind pub - !dgb get_digibyte
proc get_digibyte {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=167]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :DGB/BTC price on Cryptsy: $thisvar"

}


bind pub - !xrp get_ripple
proc get_ripple {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=454]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :XRP/BTC price on Cryptsy: $thisvar"

}


bind pub - !bitb get_bitbean
proc get_bitbean {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=468]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :BITB/BTC price on Cryptsy: $thisvar"

}

bind pub - !drk get_darkcoin
proc get_darkcoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=155]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :DRK/BTC price on Cryptsy: $thisvar"

}
##################
# Original Pairs #
##################

bind pub - !doge get_dogecoin
proc get_dogecoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=132]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :DOGE/BTC price on Cryptsy: $thisvar"

}


bind pub - !ltc get_litecoin
proc get_litecoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=3]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :LTC/BTC price on Cryptsy: $thisvar"

}


bind pub - !wdc get_worldcoin
proc get_worldcoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=14]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :WDC/BTC price on Cryptsy: $thisvar"

}


bind pub - !tips get_tipscoin
proc get_tipscoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=147]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :TIPS/LTC price on Cryptsy: $thisvar"

}


bind pub - !dgc get_digitalcoin
proc get_digitalcoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=26]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :DGC/BTC price on Cryptsy: $thisvar"

}


bind pub - !eac get_earthcoin
proc get_earthcoin {nick uhost handle chan arg} {
   set data2 [s:wget http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=139]
   putserv "PRIVMSG $chan: $data2"
   set text [regexp {lasttradeprice\"(.*?)\"\:} $data2 match thisvar]

set thisvar [
    string range $thisvar 0 [
        expr {[string first "," $thisvar]-1}
    ]
]
   regsub -all "\"" $thisvar "" thisvar
   regsub -all "\:" $thisvar "" thisvar
   putserv "PRIVMSG $chan :EAC/BTC price on Cryptsy: $thisvar"

}
