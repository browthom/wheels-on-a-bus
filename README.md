# wheels-on-a-bus
VHDL model for implementation on a Digilent Basys 3 Artix-7 development board. The 7-segment displays have rotating "ON" segments that mimick two wheels rotating. The two left-most segments are one wheel and the two right-most segments are the other wheel. If the user presses and releases BTNU or BTND, the frequency at which the segments are rotating will increase or decrease, respectively.

_The browthom/vhdl-user-component-dir repository must be imported into the Vivado project as a directory. This is done so that the top_level.vhd file can properly instantiate all components listed in its vhdl model._
