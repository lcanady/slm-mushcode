
#create Globals: Format Object <FMT> = fmt

// If they haven't been set yet, set the global
// config settings.
@if not(v(#fmt/d.lhs)) = {
        &d.jus #fmt = center
        &d.lhs #fmt = <<
        &d.rhs #fmt = >>
        &d.sep #fmt = -
        &d.len #fmt = 78
    } 

#include ./headers.mu
#include ./config.mu