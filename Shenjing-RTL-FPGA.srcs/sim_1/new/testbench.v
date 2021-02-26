`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2021 13:30:39
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


module testbench;

    parameter SRAM_WIDTH = 64;
    parameter ADDR_WIDTH = 6; //Why is it 7 in the original code?

    reg CLK,WEB;
    reg [SRAM_WIDTH-1:0]    D;
    reg [ADDR_WIDTH-1:0]    A;
    
    
    wire [SRAM_WIDTH-1:0]    Q;

    sram_custom UUT(.CLK(CLK), .D(D), .Q(Q), .A(A),.WEB(WEB));
        
    always #5 CLK = ~CLK;
    
    `define assert(signal, value) \
        if (signal !== value) begin \
            $display("ASSERTION FAILED in %m: signal != value"); \
            $finish; \
        end
    
    initial begin
        $monitor("Time = %0t clk = %0d D = %0d Q = %0d A = %0d WEB = %0d", $time, CLK, D, Q, A, WEB);
        //Try writing the number 10 to address 3
        WEB <= 1;
        CLK <= 0;
        D <= 10;
        A <= 3;
        #20;
        `assert(Q,10);
        WEB <= 0;
        //Try changing the address to 5 and write the number 20
        #20;
        D <= 20;
        A <= 5;
        WEB <= 1;
        #20;
        `assert(Q,20);
        WEB <= 0;
        #20;
        //Try changing back to address 3 and checking if it is still 10
        A <= 3;
        #20;
        `assert(Q,10);
        

//        $finish;
    end

endmodule
