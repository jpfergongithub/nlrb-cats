#!/bin/bash

# Unzip the various R-case files. There is one file for each table in the
# CATS database, for each year. There are some common (useless) PDFs in
# several of these files; I erase those. Also not that the naming convention
# for the files changes in 2001, hence the if statement.
for bar in {1999..2011}
do
    if [ "$bar" -lt 2001 ]; then
	unzip CATS_R_CASE_Data_$bar.zip
    else
	unzip R_$bar.zip
    fi
    rm *.pdf
    # Then, for each table, I run iconv to change the encoding from UTF-16
    # to UTF-8. This was a mistake in the original exporting of these files,
    # and if you don't change the encoding, any parser will assume there is
    # a non-printing null character after every real character.
    #
    # I then use xml2csv to transform the XML into a CSV file, and erase
    # the XML.
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
# At this point there is a CSV file for each table for each year. I 
# concatenate these by year, so that ultimately there is one CSV file 
# for each table, for all years. A downside of using a straight "cat >>"
# pipeline is that the variable names are repeated within the CSV. An
# upside is that it's hella fast and easy--and you can drop those out
# later.
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
# Next, I go after the "Frequently Requested Fields" files. These have
# a subset of information from the other database tables--and, maddeningly,
# some fields that *are* *not* *available* in the full database files!
# Don't ask me how this happens, I do not know.
#
# The other quirk with these is that the year of the file within the
# archive does not normally match the file in the *name* of the archive.
# (Again, don't ask.) Thus the 1999 and 2000 ZIP files *both* have the 1999
# file in them, and the (most recent) 2010 ZIP file has 2009 in it. Thus we
# can only really find information for 1999--2009, and so that's what I
# process here. The overall procedure is like that for the database files
# above, save that concatenation only has to happen to one file across years.
# Hence one less layer of loops here.
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
