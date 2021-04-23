`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2021 08:05:11
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench();

    parameter DATA_WIDTH = 16;
    parameter FIXED_POINT_PRECISION = 16;
    
    reg CLK;
    reg [DATA_WIDTH-1:0] D;
    wire [DATA_WIDTH-1:0] Q;
    wire [DATA_WIDTH+FIXED_POINT_PRECISION-1:0] SCALED_Q;

    initial begin
     CLK =0;
    end

    always #5 begin
        CLK = ~CLK;
    end
    
    `define assert(signal, value) \
        if (signal !== value) begin \
            $display("ASSERTION FAILED in %m: signal != value"); \
            $finish; \
        end
    
    fixed_point_multiply UUT(.CLK(CLK), .D(D), .Q(Q), .SCALED_Q(SCALED_Q));
    
    initial begin
        D <= 1000;
        #10;
        D <= 2000;
        #10;
        D <= 3000;
        #10
        D <= 4000;
    end
        

endmodule
