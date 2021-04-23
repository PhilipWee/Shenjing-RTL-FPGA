`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2021 12:26:44
// Design Name: 
// Module Name: accumulator
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


module accumulator (
  start,
  en,
  clk,
  rstb,
  A,
  S
);

parameter WEIGHT_WIDTH=5;
parameter DIMENSION = 128;
parameter ADDR_WIDTH = 7;

// implement a 13-bit accummulator with enable, output the sum with a flag of DONE for further adding 
input start;
input en;   // data gating from axon_in
input clk;
input rstb;
input [WEIGHT_WIDTH-1:0] A;
output reg [WEIGHT_WIDTH+ADDR_WIDTH:0] S;

//CKLNQD4BWP30P140 ICG_accum (.TE(1'b0), .E(sel), .CP(clk), .Q(clk_out)); 

`ifndef ACCUM_BB
reg [WEIGHT_WIDTH+ADDR_WIDTH:0] A_pad;

//This is probably justa holder for the weighted value
always@*
 begin
  if (A!=0)
     begin
       case (A[WEIGHT_WIDTH-1])
            2'b0: A_pad <= {{{ADDR_WIDTH+1}{1'b0}},A}; //Why 2 bits 0?  
            2'b1: A_pad <= {{{ADDR_WIDTH+1}{1'b1}},A};
       endcase
     end
 end


//If enable, then add the weighted value to the sum
always@(posedge clk)
  begin
    if (!rstb)
      S <= 13'b0;
    else if (start)
      begin
        if (en)
           begin
               S <= S + A_pad;
               $display("Hi");
           end
        else 
           S <= S;
      end
    else
      S <= 13'b0;
  end


`endif       
endmodule
