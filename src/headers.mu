/*
-------------------------------------------------------------------------------
--- fn_header -----------------------------------------------------------------
	
	The main header function for the game.  It should be used to represent
	headers, as well as footers. Global settings can be made via the
	@header command.

	SYNTAX: header(<Title>[,<just>][,<lhs>][,<rhs>][,<sep>][,<length>])

	%0: The title to put in the header.
	%1: Optional Justification.  Default: center.  Possible values are 
	    left, right, and center.
	%2: Optional string to show to the left of the title
	%3: Optional string to show to the right side of the title
	%4: Optional Seperator to fill the rest of the line. Default: Space.
	%5: Optional length of the header (min, title)
	
-------------------------------------------------------------------------------
*/

&fn_header #fmt =  
	trim(
		// Set registers For most of these, if there is no value entered, it
		// defaults to nothing.
		[setq(+, if(not(%1), default(%!/d.jus,), %1), just)]
		[setq(+, if(not(%2), default(%!/d.lhs,), %2), lhs)]
		[setq(+, if(not(%3), default(%!/d.rhs,), %3), rhs)]
		// We want to make sure %3 is also a number, and not empty.	
		[setq(+, if(not(%4), default(%!/d.sep,), %4), sep)]
		[setq(+, if(and(%5, isnum(%5)), %5, default(%!/d.len, 78)), length)]

		// Evaluate which header to display
		[switch(
			lcstr(%q<just>),
			center,
				[center(
					%q<lhs>%0%q<rhs>,
					%q<length>,
					%q<sep>
				)],
			left,
				[ljust(
					%q<lhs>%0%q<rhs>,
					%q<length>,
					%q<sep>
				)],
			right,
				[rjust(
					%q<lhs>%0%q<rhs>,
					%q<length>,
					%q<sep>
				)],
				
			// Default case.
			[center(
				%q<lhs>%0%q<rhs>,
				%q<length>,
				%q<sep>
			)]
			
		)]
	)

// Make the function global.
&ufun_header #fmt = 
	ulocal(#fmt/fn_header, %0, %1, %2, %3, %4, %5)


/*
-------------------------------------------------------------------------------
--- Global functions ----------------------------------------------------------

	This section is where the @startup and @function calls are handled,
	putting the list of given attributes into the @function list.

-------------------------------------------------------------------------------
*/
@startup #fmt = @wait 0 = {
		@dolist lattr(%!/UFUN*) = {
			@function after(##,UFUN_) = %!/##
		}
	}
