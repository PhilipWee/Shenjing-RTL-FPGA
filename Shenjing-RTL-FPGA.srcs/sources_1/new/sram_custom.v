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
        SLP, //Memory Sleep enable // Removed for now, initial look shows no sleep functionality on zcu104
        CEB, //Memory Chip Enable (Low active)
        //SD, //Memory shut down // Removed for now, intended functionality is for FPGA off/on to provide same functionality
        RSTB //Reset button
    );
    
    parameter SRAM_WIDTH = 128;
    parameter ADDR_WIDTH = 7; 
    
    input   CLK,CEB,RSTB,SLP;
    //input   SD;
    input   [SRAM_WIDTH-1:0]    D;
    input   [ADDR_WIDTH-1:0]    A;
    input   WEB;
    
    output reg [SRAM_WIDTH-1:0] Q;

    reg [SRAM_WIDTH-1:0] sram_data[SRAM_WIDTH-1:0];
    
    task RESET_MEMORY;
        begin
            for(index = 0; index < SRAM_WIDTH; index = index + 1) begin
                sram_data[index] <= 0;
            end
            Q <= 0;
        end
    endtask
    
    
    
    integer index;

//    assign Q = ~ceb_toggle ? sram_data[A] : 0;
    
    initial begin
        RESET_MEMORY;
    end
    
    always@(posedge CLK) begin
        
        if (~WEB & ~CEB)
            sram_data[A] = D;
        if (~CEB)
            Q = sram_data[A];
        else
            Q = 0;
        if (~RSTB)
            RESET_MEMORY;
        if (SLP & ~CEB)
            $display("Warning: SLP is low and CEB is high, this is outside expected behavior of IP SRAM");
    end
    
    
    
    
    
endmodule
