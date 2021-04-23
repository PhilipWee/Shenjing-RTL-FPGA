`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2021 07:53:45
// Design Name: 
// Module Name: fixed_point_multiply
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


module fixed_point_multiply(
        CLK,
        D,
        Q,
        SCALED_Q
    );
    
    parameter DATA_WIDTH = 16;
    parameter FIXED_POINT_PRECISION = 16;
    parameter SCALED_DELTA_W = 62339;
    
    input wire CLK;
    input wire [DATA_WIDTH-1:0] D;
    output wire [DATA_WIDTH-1:0] Q;
    output reg [DATA_WIDTH+FIXED_POINT_PRECISION-1:0] SCALED_Q;
    
    assign Q = SCALED_Q[DATA_WIDTH+FIXED_POINT_PRECISION-1:FIXED_POINT_PRECISION];
    
    always@(posedge CLK) begin
        SCALED_Q <= D * SCALED_DELTA_W;
    end
    
endmodule
