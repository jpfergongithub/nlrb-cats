# nlrb-rcases
Case files and code for NLRB union representation elections

This repository has copies of publicly available files from the National Labor Relations Board, holding closed-case records from the NLRB's various case-tracking databases. Also contained here are bash scripts for fixing the file encoding of those records and writing CSV-formatted files, and Stata scripts to convert those files into DTA format.

To build Stata DTA files from these zipped archives, run clean_R.sh. This will produce a series of CSV files. Note that that shell script presumes you have Unixy utilities in your command-line interface. Most should be installed by default. The exception is xml2csv, which is part of the xmlutils Python package. If you have Python installed, you can install it with "pip install xmlutils".

Note that xmlutils was written with Python 2 in mind. While you can install it for Python 3 with "pip3 install xmlutils", you'll get errors when running xml2csv. See this page for the fix:

https://stackoverflow.com/questions/39449006/xml2csv-package-error-iterparseiterator-object-has-no-attribute-next

The Stata script cleanNLRBcsvs.do creates DTA files from these CSVs. Some of the resulting files are a good deal smaller than the CSV, some are larger (especially if the CSV had long strings). The file is structured such that you can selectively highlight and "do" the blocks for the files you want to create. Note that do-file assumes that you have nlrbLabels.do (which defines any needed value labels) in the same directory, and some user-written commands (mdestring, nlrbdate, rencode, and swapout) in your Stata ado-path.

I have included an old Excel file that describes each variable. This by itself will not give you a full understanding of the representation-election process, so take it with a grain of salt. For more explicit instructions as to what each variable means, please consult the NLRB itself, or consider perusing a tome like "How to Take a Case before the NLRB," available in better law and labor libraries.
