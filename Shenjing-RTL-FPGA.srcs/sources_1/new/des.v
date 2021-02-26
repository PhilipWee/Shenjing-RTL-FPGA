`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.02.2021 12:13:16
// Design Name: 
// Module Name: des
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


module des(
        input clk,
        input rstn,
        input [1:0] addr,
        input wr,
        input sel,
        input [15:0] wdata,
        output [15:0] rdata
    );
    
reg [15:0] register [0:3];
integer i;

always @ (posedge clk) begin
    if (!rstn) begin
        for (i=0; i<4; i = i+1) begin
            register[i] <= 0;
        end
    end else begin
        if (sel & wr)
            register[addr] <= wdata;
        else
            register[addr] <= register[addr];
    end
end

assign rdata = (sel & ~wr) ? register[addr] : 0;
endmodule
