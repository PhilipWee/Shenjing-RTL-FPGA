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

    parameter SRAM_WIDTH = 128;
    parameter ADDR_WIDTH = 7;

    reg CLK,WEB,CEB,RSTB,SLP;
    reg [SRAM_WIDTH-1:0]    D;
    reg [ADDR_WIDTH-1:0]    A;
    
    
    wire [SRAM_WIDTH-1:0]    Q;

    sram_custom UUT(.CLK(CLK), .D(D), .Q(Q), .A(A),.WEB(WEB),.CEB(CEB),.RSTB(RSTB), .SLP(SLP));
        
    always #5 begin
        CLK = ~CLK;
        $display("Time = %0t CLK = %0d D = %0d Q = %0d A = %0d WEB = %0d CEB = %0d RSTB = %0d SLP = %0d", $time, CLK, D, Q, A, WEB, CEB, RSTB, SLP);
    end
    
    `define assert(signal, value) \
        if (signal !== value) begin \
            $display("ASSERTION FAILED in %m: signal != value"); \
            $finish; \
        end
    
    initial begin
        $display("Set initial low values");
        WEB <= 1;
        CLK <= 0;
        RSTB <= 1;
        CEB <= 1;
        D <= 0;
        A <= 0;
        SLP <= 0;
        #10
        $display("Apply reset first, then run tests");
        RSTB <= 0;
        #100
        RSTB <= 1;
        CEB <= 0;
        WEB <= 0;
        #10
        $display("Try writing the number 10 to address 3");
        D <= 10;
        A <= 3;
        #10
        `assert(Q,10);
        WEB <= 1;
        $display("Try changing the address to 5 and write the number 20");
        #10
        D <= 20;
        A <= 5;
        WEB <= 0;
        #10
        `assert(Q,20);
        WEB <= 1;
        #10
        $display("Try changing back to address 3 and checking if it is still 10");
        A <= 3;
        #10
        `assert(Q,10);
        $display("Try putting CEB to high and check there is no output");
        CEB <= 1;
        #10
        `assert(Q,0);
        #10 
        $display("Try putting CEB to low and check there is output");
        CEB <= 0;
        #10
        `assert(Q,10);
        #10
        $display("rewrite a value to the register (Address is already 3)");
        D <= 30;
        WEB <= 0;
        #10
        `assert(Q,30);
        WEB <= 1;
        #10
        $display("Stop the chip enable and check that there is no output");
        CEB <= 1;
        #10
        `assert(Q,0);
        #10
        $display("Renable the chip and check there is output");
        CEB <= 0;
        #10
        `assert(Q,30);
        #10
        $display("Reset the chip and check that the value has been reset to 0");
        RSTB <= 0;
        #10
        `assert(Q,0);
        RSTB <= 1;
        #10
        $display("Rewrite a value to test there is output");
        A <= 0;
        #10
        D <= 39;
        WEB <= 0;
        #10
        `assert(Q,39);
        #10
        $display("Try SLP high and CEB low");
        SLP <= 1;
        CEB <= 0;
         

    end

endmodule
