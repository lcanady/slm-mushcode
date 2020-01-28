// Macro for creating new objects & tags
#define create\s+(.*)\s?=\s?(.*) 
@if not(match(tag($2),#-1)) = {
		// Object isn't registered with the tag system, 
		// create a new nstance and register.
		@create $1;
		@tags/add $2=lastcreate(me,t);
		@set #$2 = inherit no_modify safe;
		@pemit me = $1 Created.
	}
#end

// Macro for sending warning messages
#define warn\s+(.*)
@pemit me = %ch%cyWARNING:%cn $1
#end

// Macro for sending error messages
#define error\s+(.*)
@pemit me = %ch%crERROR:%cn $1
#end

// Macro for sending info messages
#define info\s+(.*)
@pemit me = %chINFO:%cn $1
#end

