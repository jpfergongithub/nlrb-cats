* 1.0 John-Paul Ferguson 15Sep2016
capture program drop mdestring
program mdestring
	version 14
	syntax varlist[, force]
	foreach var of varlist `varlist' {
		destring `var', replace `force'
	}
end
