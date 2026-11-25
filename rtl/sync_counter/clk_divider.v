`timescale 1ns / 1ps

/*
    https://github.com/D3r3k23/clk_divider/
*/

module clk_divider
    #(
        parameter DIV = 2
    )
    (
        output reg clk_out,
        input clk_in,
        input rst
    );
    
    localparam integer TC = (DIV / 2) - 1;
    integer counter;
    
    wire terminate = (counter == TC);
        
    always @ (posedge clk_in)
    begin
        if (rst | terminate)
            counter <= 0;
        else
            counter <= counter + 1;
    end
    
    always @ (posedge clk_in)
    begin
        if (rst) clk_out <= 0;
        else if (terminate) clk_out <= ~clk_out;
    end
    
endmodule
