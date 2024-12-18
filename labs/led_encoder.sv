module led_encoder (
    input [3:0] sw,
    output [6:0] indicator
);
# (
    parameter  clk_mhz       = 50,
               w_key         = 4,
               w_sw          = 8,
               w_led         = 8,
               w_digit       = 8,
               w_gpio        = 100,

               screen_width  = 640,
               screen_height = 480,

               w_red         = 4,
               w_green       = 4,
               w_blue        = 4,

               w_x           = $clog2 ( screen_width  ),
               w_y           = $clog2 ( screen_height )
)

(
    input                        clk,
    input                        slow_clk,
    input                        rst,

    // Keys, switches, LEDs

    input        [w_key   - 1:0] key,
    input        [w_sw    - 1:0] sw,
    output logic [w_led   - 1:0] led,

    // A dynamic seven-segment display

    output logic [          7:0] abcdefgh,
    output logic [w_digit - 1:0] digit,

    // Graphics

    input        [w_x     - 1:0] x,
    input        [w_y     - 1:0] y,

    output logic [w_red   - 1:0] red,
    output logic [w_green - 1:0] green,
    output logic [w_blue  - 1:0] blue,

    // Microphone, sound output and UART

    input        [         23:0] mic,
    output       [         15:0] sound,

    input                        uart_rx,
    output                       uart_tx,

    // General-purpose Input/Output

    inout        [w_gpio  - 1:0] gpio
);

    //------------------------------------------------------------------------

    // assign led        = '0;
       assign abcdefgh   = '0;
       assign digit      = '0;
       assign red        = '0;
       assign green      = '0;
       assign blue       = '0;
       assign sound      = '0;
       assign uart_tx    = '1;

    //------------------------------------------------------------------------

    wire [2:0] in;

    generate

        if (w_key >= 3)              // Board with at least 3 keys
            assign in = key [2:0];
        else if (w_sw >= 3)          // Board with at least 3 switches
            assign in = sw  [2:0];
        else if (w_key + w_sw >= 3)  // Board with at least 3 keys + switches
            assign in = 3' ({ key, sw });
        else if (w_key >= 2)         // Board with at least 2 keys
            assign in = { key [0], key [1:0] };
        else                         // Corner case: repeat a key 3 times
            assign in = { 3 { key [0] } };

    endgenerate
    
wire [0:9] table0 =
{
    7'b1111110,
    7'b0110000,
    7'b1101101,
    7'b1111001,
    7'b0110011,
    7'b1011011,
    7'b1011111,
    7'b1110000,
    7'b1111011,
}

assign indicator = (sw > 8) ? 0 : table0[sw];

endmodule
