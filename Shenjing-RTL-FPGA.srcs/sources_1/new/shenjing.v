`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2021 13:25:48
// Design Name: 
// Module Name: shenjing
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


module shenjing(
       clk_in,
       rstb
    );

input clk_in,rstb;

always@(posedge clk_in)
    begin
        $monitor(clk_in);
    end



endmodule
