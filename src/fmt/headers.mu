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
			center, printf($:%q<sep>:^%q<length>s,%q<lhs>%b%0%b%q<rhs>),
			left, printf($:%q<sep>:-%q<length>s,%q<lhs>%b%0%b%q<rhs>),
			right, printf($:%q<sep>:%q<length>s,%q<lhs>%b%0%b%q<rhs>),
				
			// Default case.
			printf($:%q<sep>:^%q<length>s,%q<lhs>%b%0%b%q<rhs>)
		)]
	)

// Make the function global.
&ufunpr_header #fmt = 
	ulocal(#fmt/fn_header, %0, %1, %2, %3, %4, %5)

/*
-------------------------------------------------------------------------------
--- fn_footer -----------------------------------------------------------------

	Show a footer.  If the footer has text, show it in a title frame else
	just repeat the seperator for 78 characters.

-------------------------------------------------------------------------------
*/


&fn_footer #fmt = 
	[if(
		strlen(%0),
		u(fn_header, %0, right),
		repeat(
			setr(+, v(d.sep), sep),
			div( 78, strlen(%q<sep>))
		)
	)]

// Make it a global function!
&ufunpr_footer #fmt = ulocal(#fmt/fn_footer, %0)


/*
-------------------------------------------------------------------------------
--- fn_dname ------------------------------------------------------------------
	
	Display a name in full ANSI (if set) and including dbref and flag
	info if the looker has a bit-level above target.

-------------------------------------------------------------------------------
*/

&fn_dname #fmt = 
	[setq(+, 
		switch(
			lcstr(%0),
			me, %#,
			here, loc(%#),
			%0
		), 
		dbref
	)]
	[if(
		not(match(type(%q<dbref>), #-1*)),
		[cname(%q<dbref>)]
		[if( 
			controls(%#,num(%q<dbref>)), 
			%([num(%q<dbref>)][flags(num(%q<dbref>))]%) 
		)],
		[cname(*%q<dbref>)]
		[if( 
			controls(%#,num(*%q<dbref>)), 
			%([num(*%q<dbref>)][flags(num(*%q<dbref>))]%) 
		)]
	)]

// Make the function global
&ufunpr_dname u(#fmt/fn_dname, %0)


&ufunpr_title #fmt = get(%0/caption)


/*
-------------------------------------------------------------------------------
--- FUN_IS_TYPE ---------------------------------------------------------------

	So... I needed a permissioned function that could see an object's type
	without setting every room or looker as inherit.  Bad idea.  So this
	for now!

-------------------------------------------------------------------------------
*/

&fn_is_type #fmt = hastype(%0,%1)

// Make it a privelaged global.
&ufunpr_istype #fmt = ulocal(#fmt/fn_is_type,%0,%1)


/*
-------------------------------------------------------------------------------
--- FN_IDLEFMT ----------------------------------------------------------------

	Yet another friendly privileged function to use on the room parent!

-------------------------------------------------------------------------------

*/

&fn_idlefmt #fmt = rjust(singletime(idle(%0)),4)

// Make it a privileged global
	&ufunpr_idlefmt #fmt = ulocal(#fmt/fn_idlefmt, %0)


/*
-------------------------------------------------------------------------------
--- Global functions ----------------------------------------------------------

	This section is where the @startup and @function calls are handled,
	putting the list of given attributes into the @function list.

-------------------------------------------------------------------------------
*/


@startup #fmt = @wait 0 = {
        @dolist lattr(%!/UFUN_*) = {
			@function after(##,UFUN_) = %!/##
		};                
        
		// Create Global privileged functions
		@dolist lattr(%!/UFUNPR_*) = {
			@function/privileged after(##,UFUNPR_) = %!/##
        }                
	};