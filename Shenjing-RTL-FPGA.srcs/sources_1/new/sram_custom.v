`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.02.2021 10:20:40
// Design Name: 
// Module Name: sram_custom
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


module sram_custom(
        CLK,
        D, //Data
        Q, //Output
        A, //Address
        WEB, //Write enable

    );
    
    parameter SRAM_WIDTH = 64;
    parameter ADDR_WIDTH = 6; //Why is it 7 in the original code?
    
    input   CLK;
    input   [SRAM_WIDTH-1:0]    D;
    input   [ADDR_WIDTH-1:0]    A;
    input   WEB;
    
    reg [SRAM_WIDTH-1:0] sram_data[SRAM_WIDTH-1:0];
    
    output [SRAM_WIDTH-1:0] Q;
    
    assign Q = sram_data[A];
    
    always@(posedge CLK)
    begin
        if (WEB)
            sram_data[A] = D;
    end
    
    
    
endmodule
