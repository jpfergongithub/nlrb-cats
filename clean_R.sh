#!/bin/bash

for bar in {1999..2011}
do
    if [ "$bar" -lt 2001 ]; then
	unzip CATS_R_CASE_Data_$bar.zip
    else
	unzip R_$bar.zip
    fi
    rm *.pdf
    for foo in R_ACTION R_BARGAINING_UNIT R_BLOCK R_BLOCK_CASES R_CASE \
		    R_CASE_CASE_GROUP R_CASE_GROUP R_CHALLENGE_ISSUE \
		    R_CHALLENGE_TABULATION R_CLOSED_CASE R_DISMISSAL \
		    R_ELECTION R_ELECTION_TALLY R_ELECT_AGREEMENT \
		    R_ELECT_CERTIFICATION R_ELECT_SCHEDULED R_ELECT_VOTES_FOR \
		    R_IMPACT_CATEGORY R_OBJECTION_ISSUE R_PARTICIPANT \
		    R_PART_VARIANT R_POST_ELECT_BOARD_ACT R_POST_ELECT_HEARING \
		    R_POST_ELECT_RD_ACT R_PRE_ELECT_BOARD_ACT \
		    R_PRE_ELECT_HEARING R_PRE_ELECT_RD_BB \
		    R_PRE_ELECT_RD_DECISION R_PRE_ELECT_RD_ISSUES \
		    R_REOPENED_CASE R_TRANSFER_HISTORY R_WITHDRAWAL
    do
        iconv -f UTF-16 -t UTF-8 $foo.xml > $foo.xml.utf8
	rm $foo.xml
	mv $foo.xml.utf8 $foo.xml
	xml2csv --input $foo.xml --output $foo-$bar.csv --tag "row"
	rm $foo.xml
    done
done
for foo in R_ACTION R_BARGAINING_UNIT R_BLOCK R_BLOCK_CASES R_CASE \
	    R_CASE_CASE_GROUP R_CASE_GROUP R_CHALLENGE_ISSUE \
	    R_CHALLENGE_TABULATION R_CLOSED_CASE R_DISMISSAL \
	    R_ELECTION R_ELECTION_TALLY R_ELECT_AGREEMENT \
	    R_ELECT_CERTIFICATION R_ELECT_SCHEDULED R_ELECT_VOTES_FOR \
	    R_IMPACT_CATEGORY R_OBJECTION_ISSUE R_PARTICIPANT \
	    R_PART_VARIANT R_POST_ELECT_BOARD_ACT R_POST_ELECT_HEARING \
	    R_POST_ELECT_RD_ACT R_PRE_ELECT_BOARD_ACT \
	    R_PRE_ELECT_HEARING R_PRE_ELECT_RD_BB \
	    R_PRE_ELECT_RD_DECISION R_PRE_ELECT_RD_ISSUES \
	    R_REOPENED_CASE R_TRANSFER_HISTORY R_WITHDRAWAL
do
    for bar in {1999..2011}
    do
	cat $foo-$bar.csv >> $foo.csv
	rm $foo-$bar.csv
    done
done
for quux in {2000..2010}
do
    unzip CATS-FRF-R-$quux.final.zip
    rm NLRB-FOIA.xsl
done
for baz in {1999..2009}
do
    iconv -f UTF-16 -t UTF-8 CATS-FRF-R-$baz.final.xml > \
	  CATS-FRF-R-$baz.final.xml.utf8
    rm CATS-FRF-R-$baz.final.xml
    mv CATS-FRF-R-$baz.final.xml.utf8 CATS-FRF-R-$baz.final.xml
    xml2csv --input CATS-FRF-R-$baz.final.xml --output CATS-FRF-R-$baz.csv \
	    --tag "row"
    rm CATS-FRF-R-$baz.final.xml
done
for baz in {1999..2009}
do
    cat CATS-FRF-R-$baz.csv >> CATS-FRF-R.csv
    rm CATS-FRF-R-$baz.csv
done
