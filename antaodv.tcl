#Enhanced - AntAODV TCL File For 70 Nodes And Speed Of 0.5 Meters Per Second

set opt(chan)           Channel/WirelessChannel    ;# channel type
set opt(prop)           Propagation/TwoRayGround   ;# radio-propagation model
set opt(netif)          Phy/WirelessPhy            ;# network interface type
set opt(mac)            Mac/802_11                 ;# MAC type
set opt(ifq)            Queue/DropTail/PriQueue    ;# interface queue type
set opt(ll)             LL                         ;# link layer type
set opt(ant)            Antenna/OmniAntenna        ;# antenna model
set opt(ifqlen)         50                         ;# max packet in ifq
set opt(nn)             70.0
set val(energymodel) EnergyModel                   ;#set energy model
set opt(minSpeed) 0.5                              ;# movement minimum speed [m/s]
set opt(maxSpeed) 0.5                              ;# movement maximum speed [m/s]
set opt(minPause) 0.0                              ;# movement minimum pause time [s]
set opt(maxPause) 0.0                              ;# movement maximum pause time [s]
set opt(movementStart) 10.0
set opt(traffic) Node-UDP ;# data pattern                      ;# movement start time [s]                         ;# number of mobilenodes
set opt(rp)             Antnet                       ;# routing protocol
set opt(x)              1000   			   ;# X dimension of topography
set opt(y)              1000 			         ;# Y dimension of topography
set opt(stop)		2060                         ;# simulation time
set opt(seed)           1                           ;
set opt(dataStart) 1000.0                                          ;# data start time [s]
set opt(dataStop) [expr $opt(stop) - 60.0]                          ;# data stop time [s]
set opt(throughput) 5.4
set ns              [new Simulator]
#Creating trace file and nam file
set tracefd       [open antaodv$opt(nn)$opt(minSpeed).tr w]

set namtrace      [open antaodv.nam w]

$ns trace-all $tracefd
$ns namtrace-all-wireless $namtrace $opt(x) $opt(y)
#channel model
Antenna/OmniAntenna set X_ 0
Antenna/OmniAntenna set Y_ 0
Antenna/OmniAntenna set Z_ 1.5
Antenna/OmniAntenna set Gt_ 1                              ;# transmitter antenna gain
Antenna/OmniAntenna set Gr_ 1                              ;# receiver antenna gain
Phy/WirelessPhy set L_ 1.0                                 ;# system loss factor (mostly 1.0)
Phy/WirelessPhy set CPThresh_ 10.0                         ;# capture threshold in Watt
Phy/WirelessPhy set CSThresh_ 1.559e-11                    ;# Carrier Sensing threshold
Phy/WirelessPhy set RXThresh_ 3.652e-10                    ;# receiver signal threshold
Phy/WirelessPhy set freq_ 2.4e9                            ;# channel frequency (Hz)
Phy/WirelessPhy set Pt_ 0.28                               ;# transmitter signal power (Watt)
# set up topography object
set topo       [new Topography]

$topo load_flatgrid $opt(x) $opt(y)

create-god $opt(nn)

# configure the nodes
        $ns node-config -adhocRouting $opt(rp) \
                   -llType $opt(ll) \
                   -macType $opt(mac) \
                   -ifqType $opt(ifq) \
                   -ifqLen $opt(ifqlen) \
                   -antType $opt(ant) \
                   -propType $opt(prop) \
                   -phyType $opt(netif) \
                   -channelType $opt(chan) \
                   -topoInstance $topo \
                   -agentTrace ON \
                   -routerTrace ON \
                   -macTrace ON \
                   -movementTrace ON \
                   -energyModel $val(energymodel) \
                   -initialEnergy 100 \
                   -rxPower 12.5 \
                   -txPower 12.5 \
                   -idlePower 0.0 \
                   -sensePower 0.3


      for {set i 0} {$i < $opt(nn) } { incr i } {
            set node_($i) [$ns node]
      }

# Provide initial location of mobilenodes
$node_(0) set X_ 5.0
$node_(0) set Y_ 5.0
$node_(0) set Z_ 0.0

$node_(1) set X_ 490.0
$node_(1) set Y_ 285.0
$node_(1) set Z_ 0.0

$node_(2) set X_ 150.0
$node_(2) set Y_ 240.0
$node_(2) set Z_ 0.0

$node_(3) set X_ 513.0
$node_(3) set Y_ 517.0
$node_(3) set Z_ 0.0

$node_(4) set X_ 850.0
$node_(4) set Y_ 474.0
$node_(4) set Z_ 0.0

$node_(5) set X_ 36.0
$node_(5) set Y_ 529.0
$node_(5) set Z_ 0.0

$node_(6) set X_ 143.0
$node_(6) set Y_ 666.0
$node_(6) set Z_ 0.0

$node_(7) set X_ 201.0
$node_(7) set Y_ 552.0
$node_(7) set Z_ 0.0

$node_(8) set X_ 147.0
$node_(8) set Y_ 403.0
$node_(8) set Z_ 0.0

$node_(9) set X_ 230.0
$node_(9) set Y_ 291.0
$node_(9) set Z_ 0.0

$node_(10) set X_ 295.0
$node_(10) set Y_ 419.0
$node_(10) set Z_ 0.0

$node_(11) set X_ 363.0
$node_(11) set Y_ 335.0
$node_(11) set Z_ 0.0

$node_(12) set X_ 334.0
$node_(12) set Y_ 647.0
$node_(12) set Z_ 0.0

$node_(13) set X_ 304.0
$node_(13) set Y_ 777.0
$node_(13) set Z_ 0.0

$node_(14) set X_ 412.0
$node_(14) set Y_ 194.0
$node_(14) set Z_ 0.0

$node_(15) set X_ 519.0
$node_(15) set Y_ 361.0
$node_(15) set Z_ 0.0

$node_(16) set X_ 569.0
$node_(16) set Y_ 167.0
$node_(16) set Z_ 0.0

$node_(17) set X_ 349.0
$node_(17) set Y_ 546.0
$node_(17) set Z_ 0.0

$node_(18) set X_ 466.0
$node_(18) set Y_ 668.0
$node_(18) set Z_ 0.0

$node_(19) set X_ 489.0
$node_(19) set Y_ 794.0
$node_(19) set Z_ 0.0

$node_(20) set X_ 606.0
$node_(20) set Y_ 711.0
$node_(20) set Z_ 0.0

$node_(21) set X_ 630.0
$node_(21) set Y_ 626.0
$node_(21) set Z_ 0.0

$node_(22) set X_ 666.0
$node_(22) set Y_ 347.0
$node_(22) set Z_ 0.0

$node_(23) set X_ 741.0
$node_(23) set Y_ 152.0
$node_(23) set Z_ 0.0

$node_(24) set X_ 882.0
$node_(24) set Y_ 264.0
$node_(24) set Z_ 0.0

$node_(25) set X_ 761.0
$node_(25) set Y_ 441.0
$node_(25) set Z_ 0.0

$node_(26) set X_ 155.0
$node_(26) set Y_ 200.0
$node_(26) set Z_ 0.0

$node_(27) set X_ 540.0
$node_(27) set Y_ 500.0
$node_(27) set Z_ 0.0

$node_(28) set X_ 800.0
$node_(28) set Y_ 400.0
$node_(28) set Z_ 0.0

$node_(29) set X_ 72.0
$node_(29) set Y_ 429.0
$node_(29) set Z_ 0.0

$node_(30) set X_ 156.0
$node_(30) set Y_ 676.0
$node_(30) set Z_ 0.0

$node_(31) set X_ 701.0
$node_(31) set Y_ 594.0
$node_(31) set Z_ 0.0

$node_(32) set X_ 107.0
$node_(32) set Y_ 473.0
$node_(32) set Z_ 0.0

$node_(33) set X_ 130.0
$node_(33) set Y_ 491.0
$node_(33) set Z_ 0.0

$node_(34) set X_ 365.0
$node_(34) set Y_ 719.0
$node_(34) set Z_ 0.0

$node_(35) set X_ 863.0
$node_(35) set Y_ 235.0
$node_(35) set Z_ 0.0

$node_(36) set X_ 353.0
$node_(36) set Y_ 647.0
$node_(36) set Z_ 0.0

$node_(37) set X_ 704.0
$node_(37) set Y_ 977.0
$node_(37) set Z_ 0.0

$node_(38) set X_ 612.0
$node_(38) set Y_ 192.0
$node_(38) set Z_ 0.0

$node_(39) set X_ 219.0
$node_(39) set Y_ 301.0
$node_(39) set Z_ 0.0

$node_(40) set X_ 720.0
$node_(40) set Y_ 305.0
$node_(40) set Z_ 0.0

$node_(41) set X_ 490.0
$node_(41) set Y_ 610.0
$node_(41) set Z_ 0.0

$node_(42) set X_ 612.0
$node_(42) set Y_ 20.0
$node_(42) set Z_ 0.0

$node_(43) set X_ 513.0
$node_(43) set Y_ 865.0
$node_(43) set Z_ 0.0

$node_(44) set X_ 777.0
$node_(44) set Y_ 424.0
$node_(44) set Z_ 0.0

$node_(45) set X_ 236.0
$node_(45) set Y_ 499.0
$node_(45) set Z_ 0.0

$node_(46) set X_ 443.0
$node_(46) set Y_ 66.0
$node_(46) set Z_ 0.0

$node_(47) set X_ 301.0
$node_(47) set Y_ 492.0
$node_(47) set Z_ 0.0

$node_(48) set X_ 467.0
$node_(48) set Y_ 103.0
$node_(48) set Z_ 0.0

$node_(49) set X_ 52.0
$node_(49) set Y_ 391.0
$node_(49) set Z_ 0.0

$node_(50) set X_ 220.0
$node_(50) set Y_ 363.0
$node_(50) set Z_ 0.0

$node_(51) set X_ 490.0
$node_(51) set Y_ 350.0
$node_(51) set Z_ 0.0

$node_(52) set X_ 677.0
$node_(52) set Y_ 240.0
$node_(52) set Z_ 0.0

$node_(53) set X_ 513.0
$node_(53) set Y_ 545.0
$node_(53) set Z_ 0.0

$node_(54) set X_ 777.0
$node_(54) set Y_ 474.0
$node_(54) set Z_ 0.0

$node_(55) set X_ 636.0
$node_(55) set Y_ 429.0
$node_(55) set Z_ 0.0

$node_(56) set X_ 443.0
$node_(56) set Y_ 686.0
$node_(56) set Z_ 0.0

$node_(57) set X_ 301.0
$node_(57) set Y_ 592.0
$node_(57) set Z_ 0.0

$node_(58) set X_ 447.0
$node_(58) set Y_ 493.0
$node_(58) set Z_ 0.0

$node_(59) set X_ 429.0
$node_(59) set Y_ 291.0
$node_(59) set Z_ 0.0

$node_(60) set X_ 220.0
$node_(60) set Y_ 305.0
$node_(60) set Z_ 0.0

$node_(61) set X_ 490.0
$node_(61) set Y_ 310.0
$node_(61) set Z_ 0.0

$node_(62) set X_ 612.0
$node_(62) set Y_ 240.0
$node_(62) set Z_ 0.0

$node_(63) set X_ 513.0
$node_(63) set Y_ 545.0
$node_(63) set Z_ 0.0

$node_(64) set X_ 777.0
$node_(64) set Y_ 474.0
$node_(64) set Z_ 0.0

$node_(65) set X_ 636.0
$node_(65) set Y_ 429.0
$node_(65) set Z_ 0.0

$node_(66) set X_ 443.0
$node_(66) set Y_ 686.0
$node_(66) set Z_ 0.0

$node_(67) set X_ 301.0
$node_(67) set Y_ 592.0
$node_(67) set Z_ 0.0

$node_(68) set X_ 447.0
$node_(68) set Y_ 493.0
$node_(68) set Z_ 0.0

$node_(69) set X_ 429.0
$node_(69) set Y_ 291.0
$node_(69) set Z_ 0.0 8 



for { set i 0} {$i < $opt(nn)} {incr i} {
      set xr [expr rand()*$opt(x)]
      set yr [expr rand()*$opt(y)]
      set energy($i) [expr rand()*500]
      $ns node-config -initialEnergy $energy($i) \
      -rxPower 12.5 \
      -txPower 12.5 \
      -idlePower 0.0 \
      -sensePower 0.3
      set node($i) [$ns node]
      $ns at 10.0 "$node_($i) setdest $xr $yr 50"
}

# set udp0 [new Agent/UDP]
# $ns attach-agent $node_(0) $udp0

# set cbr0 [new Application/Traffic/CBR]
# $cbr0 set packetsize_ 500
# $cbr0 set interval_ 0.005
# $cbr0 attach-agent $udp0
set genSeed [new RNG]
$genSeed seed $opt(seed)
set randomSeed [new RandomVariable/Uniform]
$randomSeed use-rng $genSeed
$randomSeed set min_ 1.0
$randomSeed set max_ 100.0

set genNode [new RNG]
$genNode seed [expr [$randomSeed value]]
set randomNode [new RandomVariable/Uniform]
$randomNode use-rng $genNode
$randomNode set min_ 0
$randomNode set max_ [expr $opt(nn) - 1]

# Set a TCP connection between node_(0) and node_(1)
if {$opt(traffic) == "Node-UDP"} {
      for {set i 0} {$i < $opt(nn)} {incr i} {
            set udp($i) [new Agent/UDP]
            $ns attach-agent $node_($i) $udp($i)
            set dest [expr round([$randomNode value])]
            while {$dest == $i} {
                  set dest [expr round([$randomNode value])]
            }
            set monitor($dest) [new Agent/LossMonitor]
            $ns attach-agent $node_($dest) $monitor($dest)
            $ns connect $udp($i) $monitor($dest)
            set cbr($i) [new Application/Traffic/CBR]
            $cbr($i) attach-agent $udp($i)
            $cbr($i) set packetSize_ 1000
            $cbr($i) set random_ true
            $cbr($i) set rate_ [expr $opt(throughput) / [expr $opt(nn) * sqrt($opt(nn))]]Mb
#           $cbr($i) set rate_ [expr $val(throughput)]Mb
            $ns at [expr $opt(dataStart) + [$randomSeed value]] "$cbr($i) start"
            $ns at $opt(dataStop) "$cbr($i) stop"
#           $ns at [expr [$randomStartData value]] "$cbr($i) start"
#           set endData [expr [$randomStartData value] + [$randomEndData value]]
#           if {$endData > $val(dataStop)} {
#                 set endData $val(dataStop)
#           }
#           $ns at $endData "$cbr($i) stop"
      }
}


#Set Link 
set sink0 [new Agent/LossMonitor]
set sink1 [new Agent/LossMonitor]
set sink2 [new Agent/LossMonitor]
set sink3 [new Agent/LossMonitor]
set sink4 [new Agent/LossMonitor]
set sink5 [new Agent/LossMonitor]
set sink6 [new Agent/LossMonitor]
set sink7 [new Agent/LossMonitor]
set sink8 [new Agent/LossMonitor]
set sink9 [new Agent/LossMonitor]
set sink10 [new Agent/LossMonitor]
set sink11 [new Agent/LossMonitor]
set sink12 [new Agent/LossMonitor]
set sink13 [new Agent/LossMonitor]
set sink14 [new Agent/LossMonitor]
set sink15 [new Agent/LossMonitor]
set sink16 [new Agent/LossMonitor]
set sink17 [new Agent/LossMonitor]
set sink18 [new Agent/LossMonitor]
set sink19 [new Agent/LossMonitor]
set sink20 [new Agent/LossMonitor]
set sink21 [new Agent/LossMonitor]
set sink22 [new Agent/LossMonitor]
set sink23 [new Agent/LossMonitor]
set sink24 [new Agent/LossMonitor]
set sink25 [new Agent/LossMonitor]
set sink26 [new Agent/LossMonitor]
set sink27 [new Agent/LossMonitor]
set sink28 [new Agent/LossMonitor]
set sink29 [new Agent/LossMonitor]
set sink30 [new Agent/LossMonitor]
set sink31 [new Agent/LossMonitor]
set sink32 [new Agent/LossMonitor]
set sink33 [new Agent/LossMonitor]
set sink34 [new Agent/LossMonitor]
set sink35 [new Agent/LossMonitor]
set sink36 [new Agent/LossMonitor]
set sink37 [new Agent/LossMonitor]
set sink38 [new Agent/LossMonitor]
set sink39 [new Agent/LossMonitor]
set sink40 [new Agent/LossMonitor]
set sink41 [new Agent/LossMonitor]
set sink42 [new Agent/LossMonitor]
set sink43 [new Agent/LossMonitor]
set sink44 [new Agent/LossMonitor]
set sink45 [new Agent/LossMonitor]
set sink46 [new Agent/LossMonitor]
set sink47 [new Agent/LossMonitor]
set sink48 [new Agent/LossMonitor]
set sink49 [new Agent/LossMonitor]
set sink50 [new Agent/LossMonitor]
set sink51 [new Agent/LossMonitor]
set sink52 [new Agent/LossMonitor]
set sink53 [new Agent/LossMonitor]
set sink54 [new Agent/LossMonitor]
set sink55 [new Agent/LossMonitor]
set sink56 [new Agent/LossMonitor]
set sink57 [new Agent/LossMonitor]
set sink58 [new Agent/LossMonitor]
set sink59 [new Agent/LossMonitor]
set sink60 [new Agent/LossMonitor]
set sink61 [new Agent/LossMonitor]
set sink62 [new Agent/LossMonitor]
set sink63 [new Agent/LossMonitor]
set sink64 [new Agent/LossMonitor]
set sink65 [new Agent/LossMonitor]
set sink66 [new Agent/LossMonitor]
set sink67 [new Agent/LossMonitor]
set sink68 [new Agent/LossMonitor]
set sink69 [new Agent/LossMonitor]


#Attach Agents
$ns attach-agent $node_(0) $sink0
$ns attach-agent $node_(1) $sink1
$ns attach-agent $node_(2) $sink2
$ns attach-agent $node_(3) $sink3
$ns attach-agent $node_(4) $sink4
$ns attach-agent $node_(5) $sink5
$ns attach-agent $node_(6) $sink6
$ns attach-agent $node_(7) $sink7
$ns attach-agent $node_(8) $sink8
$ns attach-agent $node_(9) $sink9
$ns attach-agent $node_(10) $sink10
$ns attach-agent $node_(11) $sink11
$ns attach-agent $node_(12) $sink12
$ns attach-agent $node_(13) $sink13
$ns attach-agent $node_(14) $sink14
$ns attach-agent $node_(15) $sink15
$ns attach-agent $node_(16) $sink16
$ns attach-agent $node_(17) $sink17
$ns attach-agent $node_(18) $sink18
$ns attach-agent $node_(19) $sink19
$ns attach-agent $node_(20) $sink20
$ns attach-agent $node_(21) $sink22
$ns attach-agent $node_(23) $sink23
$ns attach-agent $node_(24) $sink24
$ns attach-agent $node_(25) $sink25
$ns attach-agent $node_(26) $sink26
$ns attach-agent $node_(27) $sink27
$ns attach-agent $node_(28) $sink28
$ns attach-agent $node_(29) $sink29
$ns attach-agent $node_(30) $sink30
$ns attach-agent $node_(31) $sink31
$ns attach-agent $node_(32) $sink32
$ns attach-agent $node_(33) $sink33
$ns attach-agent $node_(34) $sink34
$ns attach-agent $node_(35) $sink35
$ns attach-agent $node_(36) $sink36
$ns attach-agent $node_(37) $sink37
$ns attach-agent $node_(38) $sink38
$ns attach-agent $node_(39) $sink39
$ns attach-agent $node_(40) $sink40
$ns attach-agent $node_(41) $sink41
$ns attach-agent $node_(42) $sink42
$ns attach-agent $node_(43) $sink43
$ns attach-agent $node_(44) $sink44
$ns attach-agent $node_(45) $sink45
$ns attach-agent $node_(46) $sink46
$ns attach-agent $node_(47) $sink47
$ns attach-agent $node_(48) $sink48
$ns attach-agent $node_(49) $sink49
$ns attach-agent $node_(50) $sink50
$ns attach-agent $node_(51) $sink51
$ns attach-agent $node_(52) $sink52
$ns attach-agent $node_(53) $sink53
$ns attach-agent $node_(54) $sink54
$ns attach-agent $node_(55) $sink55
$ns attach-agent $node_(56) $sink56
$ns attach-agent $node_(57) $sink57
$ns attach-agent $node_(58) $sink58
$ns attach-agent $node_(59) $sink59
$ns attach-agent $node_(60) $sink60
$ns attach-agent $node_(61) $sink61
$ns attach-agent $node_(62) $sink62
$ns attach-agent $node_(63) $sink63
$ns attach-agent $node_(64) $sink64
$ns attach-agent $node_(65) $sink65
$ns attach-agent $node_(66) $sink66
$ns attach-agent $node_(67) $sink67
$ns attach-agent $node_(68) $sink68
$ns attach-agent $node_(69) $sink69

#Instantiate The Agents 
set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(9) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(1) $tcp
$ns attach-agent $node_(2) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(3) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(4) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(5) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(6) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(7) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(8) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(9) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(10) $tcp
$ns attach-agent $node_(2) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(11) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(12) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(13) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(14) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(15) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(16) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(17) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(18) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(19) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(1) $tcp
$ns attach-agent $node_(19) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(20) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(21) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(22) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(23) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(24) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(25) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(26) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(27) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(28) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(29) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"


set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(30) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(31) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(32) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(33) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(34) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(35) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(36) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(37) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(38) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(39) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(40) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(41) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(42) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(43) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(44) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(45) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(46) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(47) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(48) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(49) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(50) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(51) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(52) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(53) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(54) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(55) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(56) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(57) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(58) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(59) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(60) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(61) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(62) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(63) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(64) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(65) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(66) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(67) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(68) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP] 
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(69) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"



# Define node initial position in nam
for {set i 0} {$i < $opt(nn)} { incr i } {
# 30 defines the node size for nam
$ns initial_node_pos $node_($i) 30
}

# Telling nodes when the simulation ends
for {set i 0} {$i < $opt(nn) } { incr i } {
    $ns at $opt(stop) "$node_($i) reset";
}

# ending nam and the simulation
$ns at $opt(stop) "$ns nam-end-wireless $opt(stop)"
$ns at $opt(stop) "stop"
$ns at 200.01 "puts \"end simulation\" ; $ns halt"
proc stop {} {
    global ns tracefd namtrace
    $ns flush-trace
    close $tracefd
    close $namtrace
#exec nam aodv.nam &
exit 0
}

$ns run

