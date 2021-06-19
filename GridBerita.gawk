#!/usr/bin/env -S gawk -f

BEGIN {
	print "<!DOCTYPE HTML>"
	print "<HTML>"
	print "	"
	print "	<META CHARSET='UTF-8' />"
	print "	"
	print "	<STYLE>"
	print "		.page-header {"
	print "			color: #096;"
	print "			font-size: 32pt;"
	print "			margin: 0;"
	print "			text-decoration: underline;"
	print "		}"
	print "		.kumpulan-header {"
	print "			margin: 8px 0 0 0;"
	print "			text-shadow: #0003 2px 2px;"
	print "		}"
	print "		.petak {"
	print "			display: inline-block;"
	print "			width: 144px;"
	print "			height: 144px;"
	print "			padding: 8px 4px;"
	print "			margin: 8px;"
	print "			"
	print "			border: 1px solid lightgrey;"
	print "			background-color: #00000010;"
	print "			"
	print "			text-align: center;"
	print "		}"
	print "		.petak .logo {"
	print "			width: 96px;"
	print "			height: 96px;"
	print "		}"
	print "		.petak .pejabat {"
	print "			font-size: 10pt;"
	print "		}"
	print "	</STYLE>"
	print "	"
	print "	<BODY>"
	print "		<H1 CLASS='page-header'>Senarai Akhbar Malaysia</H1>"
}

function pushAkhbarInProgress() {
	if (!akhbar["nama"]) return;
	# We didn't have an akhbar in the works.

	print "<ARTICLE CLASS='petak'>"
	print "<IMG CLASS='logo' SRC='images/" akhbar["asset_id"] ".png'>"
	print "<BR>"
	print "<A CLASS='laman' HREF='" akhbar["laman"] "' TARGET='_blank'>"
	print akhbar["nama"]
	print "</A>"
	print "<BR>"
	print "<SPAN CLASS='pejabat'>" akhbar["pejabat"] "</SPAN>"
	print "</ARTICLE>"
	
	delete akhbar
}

match($0, / *"(.*)": *"(.*)" */, captureGroups) {
	key = captureGroups[1]
	value = captureGroups[2]
	
	if (key == "nama") pushAkhbarInProgress()
	akhbar[key] = value
}

END {
	pushAkhbarInProgress()

	print "	</BODY>"
	print "	"
	print "</HTML>"
}
