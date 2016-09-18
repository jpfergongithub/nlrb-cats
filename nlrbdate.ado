* 1.0 John-Paul Ferguson 15sep2016
capture program drop nlrbdate
program nlrbdate
	version 11
	syntax varlist
	foreach var of varlist `varlist' {
		quietly {
			generate _d_`var' = dofc(clock(subinstr(`var',"T"," ",.),"YMDhms"))
			format _d_`var' %td
			swapout `var' _d_`var'
		}
	}
end
