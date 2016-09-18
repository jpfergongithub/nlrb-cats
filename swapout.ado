*1.0 John-Paul Ferguson 14jul2011
capture program drop swapout
program swapout
	version 11
	quietly {
		move `2' `1'
		drop `1'
		rename `2' `1'
	}
end
