* 1.0 John-Paul Ferguson 15sep2016
capture program drop rencode
program rencode
	version 11
	syntax varlist[, Label(string) NOExtend]
	quietly {
		encode `varlist', generate(`varlist'_e) label(`label') `noextend'
		swapout `varlist' `varlist'_e
	}
end
