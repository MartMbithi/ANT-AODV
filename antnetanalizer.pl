#!/usr/bin/perl
#Compine This File With PDRAnalizer To Parse .Tr file generated by ns2 when execute antaodv.tcl
$tracefile=$ARGV[0];
$granularity=$ARGV[1];

$ofile="Enhanced-Antnet.csv";
open OUT, ">$ofile" or die "$0 cannot open output file $ofile: $!";

open (DR,STDIN);
$gclock=0;

#Data Packet Information
$dataSent = 0;
$dataRecv = 0;
$routerDrop = 0;

#AntAODV Packet Information
$antaomdvSent = 0;
$antaomdvRecv = 0;

$antaomdvSentRequest = 0;
$antaomdvRecvRequest = 0;
$antaomdvDropRequest = 0;

$antaomdvSentReply = 0;
$antaomdvRecvReply = 0;
$antaomdvDropReply = 0;

if ($granularity==0) {$granularity=30;}

while(<>){
	chomp;
	if (/^s/){
		if (/^s.*antnet/) {
			$antaomdvSent++;
			if (/^s.*REQUEST/) {
				$antaomdvSendRequest++;
			}
			elsif (/^s.*REPLY/) {
				$antaomdvSendReply++;
			}
		}
		elsif (/^s.*AGT/) {
			$dataSent++;			
		}		
		
	} elsif (/^r/){
		if (/^r.*antnet/) {
			$antaomdvRecv++;
			if (/^r.*REQUEST/) {
				$antaomdvRecvRequest++;
			}
			elsif (/^r.*REPLY/) {
				$antaomdvRecvReply++;
			}
			
		}
		elsif (/^r.*AGT/) {
			$dataRecv++;			
		}


		
	} elsif (/^D/) {
		if (/^D.*antnet/) {
			if (/^D.*REQUEST/) {
				$antaomdvDropRequest++;
			}
			elsif (/^D.*REPLY/) {
				$antaomdvDropReply++;
			}
			
		}
		if (/^D.*RTR/) {
			$routerDrop++;
		}
	}
	 
}

close DR;

$delivery_ratio = 100*$dataRecv/$dataSent;

print "AntAOMDV Sent		: $antaomdvSent\n";
print "AntAOMDV Recv		: $antaomdvRecv\n";
print "Data Sent		: $dataSent\n";
print "Data Recv		: $dataRecv\n";
print "Router Drop		: $routerDrop\n";
print "Delivery Ratio		: $delivery_ratio \n";

print OUT "Messages Sent,$dataSent\n";
print OUT "Messages Recieved,$dataRecv\n";
print OUT "Messages Dropped,$routerDrop\n";
print OUT "Delivery Rate,$delivery_ratio\n";

close OUT;

