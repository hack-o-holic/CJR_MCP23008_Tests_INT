CJR_MCP23008_Tests_INT
======================

My first test project using Git and Github.


Basic pin reading and pullup test for the MCP23008 I/O expander
public domain!

Connect pin #1 of the expander to Analog 5 (i2c clock)
Connect pin #2 of the expander to Analog 4 (i2c data)
Connect pins #3, 4 and 5 of the expander to ground (address selection)
Connect pin #6 and 18 of the expander to 5V (power and reset disable)
Connect pin #9 of the expander to ground (common ground)

Connect pin #10 to UP button
Connect pin #11 to DOWN button
Connect pin #12 to LEFT button
Connect pin #13 to RIGHT button
Connect pin #14 to SELECT button

This sketch depends upon my version of the MCP23008 which includes my
basic interrupt implementation.  CJR 6/27/2012
