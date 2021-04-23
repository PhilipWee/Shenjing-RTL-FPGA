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
    
    input   CLK,CEB,RSTB,SLP,WEB;
    //input   SD;
    input   [SRAM_WIDTH-1:0]    D;
    input   [ADDR_WIDTH-1:0]    A;
    
    
    //Create internal variables that only get updated on posedge clock
    reg [SRAM_WIDTH-1:0] _D;
    reg [ADDR_WIDTH-1:0] _A;
    
    reg   _CEB,_SLP,_WEB;
    
    output [SRAM_WIDTH-1:0] Q;

    reg [SRAM_WIDTH-1:0] sram_data[SRAM_WIDTH-1:0];
    
    task RESET_MEMORY;
        begin
            for(index = 0; index < SRAM_WIDTH; index = index + 1) begin
                sram_data[index] <= 0;
            end
        end
    endtask
    
    task UPDATE_INTERNAL_PARAMS;
        begin
            _CEB <= CEB;
            _A <= A;
        end
    endtask

    integer index;

    assign Q = ~_CEB ? sram_data[_A] : 0; //Will now only update on posedge clock with non-blocking assignments
    
    always@(posedge CLK) begin
        if (~RSTB)
            RESET_MEMORY;
        else
            begin
                UPDATE_INTERNAL_PARAMS;
                if (~WEB & ~CEB)
                    sram_data[A] <= D;
                if (SLP & ~CEB)
                    $display("Warning: SLP is low and CEB is high, this is outside expected behavior of IP SRAM");
            end
    end
    
    
    
    
    
endmodule
