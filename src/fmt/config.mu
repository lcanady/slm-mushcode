/*
-----------------------------------------------------------------------------
--- Command: @fmt -----------------------------------------------------------

    This is the main configuration command for the global format system.
    WIth it the default settings can be updated and personalized.  Any
    settings modified will persist through any future mushcode updates.

    Syntax:
        @fmt[/help] A list of settings available for updating.
        @fmt <config>=<value> Configure a default setting.

-----------------------------------------------------------------------------
*/

&cmd_@fmt #fmt = $^@?fmt?$:
    
    // Check to make sure the enactor is immortal before allowing
    // them access to the config system.
    @assert hasflag(%#/i) = {
        @pemit %#= Permission deined.
    };

    @pemit %# = 
        [header(Global Formating Configs)]%r%r
        %b* %chjus%cn - Set the default justifaction for the header (%chdefault: center%cn)%r
        %b* %chlhs%cn - The text on the left-hand side of the title. (%chdefault: <<%cn)%r
        %b* %chrhs%cn - The text on the right-hand side of the title. (%chdefault: >>%cn)%r
        %b* %chsep%cn - The characters used to fill space (%chdefault: -%cn)%r
        %b* %chlen%cn - The default line length for a header. (%chdefault: 78%cn)%r%r
        [repeat(v(d.sep), v(d.len))]

// Set the command to process regular expressions.
@set #fmt/cmd_@fmt = reg

// Add the header config settings to the format object
@fo me = &config #fmt = [setunion(v(config), jus lhs rhs sep len)]

// Set a format object config setting.
&cmd_@fmt/config #fmt = $^@?fmt\s+(.*):
    
    // Check to make sure the enactor is immortal before allowing
    // them access to the config system.
    @assert hasflag(%#,immortal) = {
        @pemit %#= Permission deined.
    };

    [setq(+, before(%1,=), lhs)]
    [setq(+, trim(after(%1,=)),rhs)];        

    @if member(v(config), lcstr(%q<lhs>)) = {
        &d.%q<lhs> %! = %q<rhs>;
        @pemit %# = %chFormat>>%cn Config %ch[lcstr(%q<lhs>)]%cn 
          set to: %q<rhs>;    
    }, {
        @pemit %#=%chFormat>>%cn Invalid config setting.
    }

//Set the to evaluate regex
@set #fmt/cmd_@fmt/config #fmt = reg