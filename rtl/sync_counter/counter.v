`timescale 1ns / 1ps

module counter
    #(
        parameter COUNTER_WIDTH = 4
    )
    (
        output reg [COUNTER_WIDTH - 1 : 0] counter,
        input clk,
        input rst,
        input en        
    );
    
    always @ (posedge clk, posedge rst)
    begin
        if (rst)
            counter <= 0;
        else if (en)
            counter <= counter + 1;
    end
    
endmodule
