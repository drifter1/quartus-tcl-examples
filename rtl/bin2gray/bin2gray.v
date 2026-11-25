`timescale 1ns / 1ps

module bin2gray #(
        parameter N = 4
    )
    (
        output [N - 1 : 0] gray,
        input [N - 1 : 0] bin
    );
    
    genvar i;
    generate
    for (i = 0; i < N - 1; i = i + 1) begin : generate_loop
        assign gray[i] = bin[i] ^ bin[i+1];
    end
    endgenerate
    
    assign gray[N-1] = bin[N-1];
    
endmodule

