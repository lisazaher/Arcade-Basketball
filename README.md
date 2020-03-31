#Details about my final project

**Team Members:** Lisa Zaher, Ben Morehead

*Introduction*

We designed and produced a down-scaled version of the popular basketball arcade game. The game incorporated hardware (PS2 keyboard, VGA, DE1-SoC), as well as a physical game box (frame, LDR circuit). A user starts the game by pressing the “go” button (KEY[1]), and would write their name using the PS2 keyboard. As they wrote their name, the letter would appear on the VGA screen. Upon clicking the “enter” key, the game would start and the LEDs on the frame would turn on. The counter on the VGA would start counting down and the score would increase as the user scores. At the end of the game, the high score is updated. The score and username don’t change unless a user is in the beginning of the game (before the counter starts), so shooting or attempting to write using the keyboard will not work otherwise.
We decided to build a scaled-down version of this popular game to provide users with the opportunity to install this game in smaller spaces such as bedrooms, and offices. Technology continues to become more powerful and faster, and continues to shrink in size. We wanted to incorporate that notion into our game, and took on the challenge of making the standard game smaller, but still as functional.
As second year students, we have started to develop skills that span into multiple disciplines. We wanted to design a game that incorporated and showcased our various skills. The basketball game required a frame that we needed to build, a circuit that we needed to sauder and integrate, as well as hardware that we needed to program. The combination of all these aspects into a fully working game demonstrated our wide range of skills, and felt very rewarding.

*The Design*

**Full Game (Top module)** 
The top module connected all of the sub modules needed for the game. It handled the user inputs from the circuit and keyboard, sent them to the proper sub modules that interpreted them and sent the proper signals to the game module. The game module would output the x,y, colour, and plot signals that went into the VGA. To ensure that the VGA worked properly, the score and time from the game would display on HEX5 to HEX 0 (HEX5 and HEX4 for current score, HEX3 and HEX2 for high score, and HEX1 and HEX0 for timer).

**Sensor** 
The sensor used to detect whether or not the ball went it to the basket was made using a laser pointer and an Light Dependent Resistor(LDR). The laser would point to the LDR and thus the
resistance of the device would be low (approximately 1000 Ωs) and thus the output voltage that gets read by the GPIO ports on the DE1-SOC would be past the threshold voltage that equates to a ‘HIGH’ signal. As soon as something blocks the path between the laser and the LEDR, in this case the ball, the light is no longer focused on the resistor, and thus the resistance jumps up extremely high (approximately 60 000Ωs). This lowers the output voltage to a low value and equates to a ‘LOW’ signal on the FPGA. This process is what determines whether to increase the score or not, and the verilog is based off of the readings from the GPIO inputs.

**Keyboard**
This module handled the input from the PS2 keyboard. It used the demo code (namely, PS2_control, and the in and out signals), an FSM, and a key decoder. It read the keys’ signals to determine the letter that was pressed, store that value into a register, and sent those signals to the game. It made use of registers to store the value of each letter pressed to a maximum of 5 letters. When the user presses the “enter” key, the keyboard module sends the signal to start the game.

**Game** 
The game module connected all of the parts that needed to work together to make decisions during the game. It connected the signals between the parsing of the signals, the game logic, and the display. It contained a gamestate module that interpreted the circuit input to update the score, and updated the high score and name at the end of the game. The timer module would count at a frequency of 1Hz, and 50 frames per second. The gamestate and timer sent signals to the display module to update the time, score, and name, while someone was playing. The display would update the registers and send signals to the draw module. The draw module would read the data from the display, and determine the correct X, Y, Colour, and Plot signal to send to the VGA.
Draw (symbol and box drawer) (See Appendix D)
*i) Symbol Drawer*
Given signals (symbol, scale, X, Y, Colour, and go) from the game logic, this module would read from the ROM to find the correct pixel color to plot, and would send information to the square drawer to draw every pixel from the sprites. It would update the location of the next pixel to write based on the scale of the drawing.
*ii) Box Drawer*
This is the actual module that communicated with the VGA. Given a location, scale, and color, it would draw a “scale”-bit square. This module would communicate with the symbol drawer when it finished drawing, and wait for it’s next square to draw.

**VGA**
The game information (time, current name and score, high score and name) would be displayed using the VGA. It received signals from the square drawer, which came from the symbol drawer, which came from the game logic, which came from the keyboard or sensors.
# lisazaher
