#include "forth.h"

// Top-level routine for starting Forth

main()
{
    cell *up;

    init_io();   // Perform platform-specific initialization

    up = init_forth();
    execute_word("app", up);  // Call the top-level application word
}
