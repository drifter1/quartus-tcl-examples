`timescale 1ns / 1ps

module sync_counter
    #(
        parameter LED_COUNT = 4,
        parameter DIV = 2**25
    )
    (
        output reg [LED_COUNT - 1 : 0] led_reg,
        input clk,
        input rst,
        input en
    );
    
    wire clk_div;
   
    clk_divider #(
        .DIV(DIV)
    ) clk_divider_1
    (
        .clk_out(clk_div),
        .clk_in(clk),
        .rst(rst)
    );
    
    wire [LED_COUNT - 1 : 0] led;
    
    counter #(
        .COUNTER_WIDTH(LED_COUNT)
    ) counter_1
    (
        .counter(led),
        .clk(clk_div),
        .rst(rst),
        .en(en)
    );
    
    always @ (posedge clk)
    begin
    if (rst)
        led_reg <= 0;
    else 
        led_reg <= led;
    end
    
endmodule
