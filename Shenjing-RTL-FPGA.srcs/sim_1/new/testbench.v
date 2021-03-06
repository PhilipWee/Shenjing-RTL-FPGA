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

    reg CLK,WEB,SLP,CEB,SD,RSTB;
    reg [SRAM_WIDTH-1:0]    D;
    reg [ADDR_WIDTH-1:0]    A;
    
    
    wire [SRAM_WIDTH-1:0]    Q;

    sram_custom UUT(.CLK(CLK), .D(D), .Q(Q), .A(A),.WEB(WEB),.SLP(SLP),.CEB(CEB),.SD(SD),.RSTB(RSTB));
        
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
        RSTB <= 0;
        SLP <= 0;
        CEB <= 0;
        SD <= 0;
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
        //Try putting CEB to high and check if there is output
        CEB <= 1;
        #5
        `assert(Q,0);
        #20; 
        //Try putting CEB to low and check if there is output
        CEB <= 0;
        #5;
        `assert(Q,10);
        #20;
        //Try shutting down and checking if there is output
        SD <= 1;
        #5
        `assert(Q,0);
        #20
        //Try changing the address while it has been shut down and checking if there is output
        A <= 5;
        #5
        `assert(Q,0);
        //Try turning it back on and checking that there is still no output
        SD <= 0;
        #5
        `assert(Q,0);
        //rewrite a value to the register (Address is already 5)
        D <= 30;
        WEB <= 1;
        #20;
        `assert(Q,30);
        WEB <= 0;
        #20
        //Stop the chip enable and check that there is no output
        CEB <= 1;
        #5
        `assert(Q,0);
        #20
        //Renable the chip and check there is output
        CEB <= 0;
        #5
        `assert(Q,30);
        #20
        //Reset the chip and check that the value has been reset to 0
        RSTB <= 1;
        #20
        `assert(Q,0);
        RSTB <= 0;
        #20
        //Rewrite a value to test there is output
        A <= 0;
        #5
        D <= 39;
        WEB <= 1;
        #20
        `assert(Q,39);
        #20
        //Put the chip to sleep, change the data in and see if there is any output changes
        SLP <= 1;
        D <= 22;
        #20
        `assert(Q,39);
        //End of tests
//        $finish;
    end

endmodule
