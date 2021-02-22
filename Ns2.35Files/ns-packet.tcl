
PacketHeaderManager set hdrlen_ 0

# XXX Common header should ALWAYS be present
PacketHeaderManager set tab_(Common) 1

proc add-packet-header args {
	foreach cl $args {
		PacketHeaderManager set tab_(PacketHeader/$cl) 1
	}
}

proc add-all-packet-headers {} {
	PacketHeaderManager instvar tab_
	foreach cl [PacketHeader info subclass] {
		if [info exists tab_($cl)] { 
			PacketHeaderManager set tab_($cl) 1
		}
	}
}

proc remove-packet-header args {
	foreach cl $args {
		if { $cl == "Common" } {
			warn "Cannot exclude common packet header."
			continue
		}
		PacketHeaderManager unset tab_(PacketHeader/$cl)
	}
}

proc remove-all-packet-headers {} {
	PacketHeaderManager instvar tab_
	foreach cl [PacketHeader info subclass] {
		if { $cl != "PacketHeader/Common" } {
			if [info exists tab_($cl)] { 
				PacketHeaderManager unset tab_($cl)
			}
		}
	}
}

set protolist {
# Common:
	Common 
	Flags
	IP 	# IP
# Routing Protocols:
	NV 	# NixVector classifier for stateless routing 
	rtProtoDV 	# distance vector routing protocol
	rtProtoLS 	# link state routing protocol
	SR 	# source routing, dsr/hdr_sr.cc
	Src_rt 	# source routing, src_rtg/hdr_src.cc
# Routers:
	LDP 	# mpls/ldp.cc
	MPLS 	# MPLS, MultiProtocol Label Switching
	Resv 	# Token buckets, for reservations.
	UMP 	# Admission control, adc/ump.cc
	Pushback 	# Pushback, router-to-router
# Multicast:
  	aSRM 	# mcast/srm.cc
	CtrMcast 	# Centralized Multicast routing
	mcastCtrl 	# mcast/mcast_ctrl.cc
	MFTP 	# Multicast File Transfer Protocol
	PGM 	# PGM multicast
	PGM_SPM # PGM multicast
	PGM_NAK # PGM multicast
  	SRM 	# SRM, multicast
  	SRMEXT 	# SRM, multicast
# Transport Protocols and related protocols:
	HttpInval 	# HTTP
	IVS 	# Inria video conferencing system 
	QS 	# Quick-Start
	RAP 	# Rate Adaption Protocol, transport protocol.
	RTP 	# RTP.  Also used for UPD traffic.
	SCTP 	# SCTP, transport protocol
	Snoop 	# tcp/snoop.cc
	TCP 	# TCP, transport protocol
	TCPA 	# Asymmetric TCP, transport protocol
	TFRC 	# TFRC, transport protocol
	TFRC_ACK 	# TFRC, transport protocol
	XCP 	# XCP, transport protocol
        DCCP            # DCCP, transport protocol
        DCCP_ACK        # DCCP, transport protocol
        DCCP_RESET      # DCCP, transport protocol
        DCCP_REQ        # DCCP, transport protocol
        DCCP_RESP       # DCCP, transport protocol
        DCCP_DATA       # DCCP, transport protocol
        DCCP_DATAACK    # DCCP, transport protocol
        DCCP_CLOSE      # DCCP, transport protocol
        DCCP_CLOSEREQ   # DCCP, transport protocol
# Application-Layer Protocols:
	Message # a protocol to carry text messages
	Ping 	# Ping
    PBC     # PBC
# Wireless:
	ARP 	# Address Resolution Protocol, network wireless stack
	GAF 	# Geographic Adaptive Delity, for ad-hoc networks
	LL 	# network wireless stack
        LRWPAN  # zheng, wpan/p802_15_4mac.cc
	Mac 	# network wireless stack
# Mobility, Ad-Hoc Networks, Sensor Nets:
	Antnet	
	AODV 	# routing protocol for ad-hoc networks
	Diffusion 	# diffusion/diffusion.cc
	IMEP 	# Internet MANET Encapsulation Protocol, for ad-hoc networks
        MIP 	# Mobile IP, mobile/mip-reg.cc
	Smac 	# Sensor-MAC
	TORA 	# routing protocol for ad-hoc networks
	MDART 	# routing protocol for ad-hoc networks
	# AOMDV patch
	AOMDV
# Other:
	Encap 	# common/encap.cc
        IPinIP 	# IP encapsulation 
	HDLC 	# High Level Data Link Control
}
set allhdrs [regsub -all {#.*?\n} $protolist \n]; # strip comments from above
foreach prot $allhdrs {
	add-packet-header $prot
}

proc PktHdr_offset { hdrName {field ""} } {
	set offset [$hdrName offset]
	if { $field != "" } {
		# This requires that fields inside the packet header must
		# be exported via PacketHeaderClass::export_offsets(), which
		# should use PacketHeaderClass::field_offset() to export 
		# field offsets into otcl space.
		incr offset [$hdrName set offset_($field)]
	}
	return $offset
}

Simulator instproc create_packetformat { } {
	PacketHeaderManager instvar tab_
	set pm [new PacketHeaderManager]
	foreach cl [PacketHeader info subclass] {
		if [info exists tab_($cl)] {
			set off [$pm allochdr $cl]
			$cl offset $off
		}
	}
	$self set packetManager_ $pm
}

PacketHeaderManager instproc allochdr cl {
	set size [$cl set hdrlen_]

	$self instvar hdrlen_
	set NS_ALIGN 8
	# round up to nearest NS_ALIGN bytes
	# (needed on sparc/solaris)
	set incr [expr ($size + ($NS_ALIGN-1)) & ~($NS_ALIGN-1)]
	set base $hdrlen_
	incr hdrlen_ $incr

	return $base
}

# XXX Old code. Do NOT delete for now. - Aug 30, 2000

# Initialization
#  foreach cl [PacketHeader info subclass] {
#  	PacketHeaderManager set vartab_($cl) ""
#  }

# So that not all packet headers should be initialized here.
# E.g., the link state routing header is initialized using this proc in 
# ns-rtProtoLS.tcl; because link state may be turned off when STL is not 
# available, this saves us a ns-packet.tcl.in
#  proc create-packet-header { cl var } {
#  	PacketHeaderManager set vartab_(PacketHeader/$cl) $var
#  }

# If you need to save some memory, you can disable unneeded packet headers
# by commenting them out from the list below
#  foreach pair {
#  	{ Common off_cmn_ }
#  	{ Mac off_mac_ }
#  	{ LL off_ll_ }
#  	{ ARP off_arp_ }
#  	{ Snoop off_snoop_ }
#  	{ SR off_SR_ }
#  	{ IP off_ip_ }
#  	{ TCP off_tcp_ }
#  	{ TCPA off_tcpasym_ }
#  	{ Flags off_flags_ }
#  	{ TORA off_TORA_ }
#  	{ AODV off_AODV_ }
#  	{ IMEP off_IMEP_ }
#  	{ RTP off_rtp_ } 
#  	{ Message off_msg_ }
#  	{ IVS off_ivs_ }
#  	{ rtProtoDV off_DV_ }
#  	{ CtrMcast off_CtrMcast_ }
#  	{ mcastCtrl off_mcast_ctrl_ }
#    	{ aSRM off_asrm_ }
#    	{ SRM off_srm_ }
#    	{ SRMEXT off_srm_ext_}
#  	{ Resv off_resv_}
#  	{ HttpInval off_inv_}
#          { IPinIP off_ipinip_} 
#          { MIP off_mip_}
#  	{ MFTP off_mftp_ }
#  	{ Encap off_encap_ }
#  	{ RAP off_rap_ }
#  	{ UMP off_ump_  }
#  	{ TFRC off_tfrm_ }
#  	{ Ping off_ping_ }
#  	{ rtProtoLS off_LS_ }
#  	{ MPLS off_mpls_ }
#	{ GAF off_gaf_ } 
#  	{ LDP off_ldp_ }
#  } {
#  	create-packet-header [lindex $pair 0] [lindex $pair 1]
#  }

#  proc PktHdr_offset {hdrName {field ""}} {
#  	set var [PacketHeaderManager set vartab_($hdrName)]
#  	set offset [TclObject set $var]
#  	if {$field != ""} {
#  		incr offset [$hdrName set offset_($field)]
#  	}
#  	return $offset
#  }

#  Simulator instproc create_packetformat { } {
#  	PacketHeaderManager instvar vartab_
#  	set pm [new PacketHeaderManager]
#  	foreach cl [PacketHeader info subclass] {
#  		if {[info exists vartab_($cl)] && $vartab_($cl) != ""} {
#  			set off [$pm allochdr [lindex [split $cl /] 1]]
#  			set var [PacketHeaderManager set vartab_($cl)]
#  			TclObject set $var $off
#  			$cl offset $off
#  		}
#  	}
#  	$self set packetManager_ $pm
#  }
