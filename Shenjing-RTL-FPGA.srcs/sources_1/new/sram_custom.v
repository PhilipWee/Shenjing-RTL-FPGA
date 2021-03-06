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
        SLP, //Memory Sleep enable
        CEB, //Memory Chip Enable (Low active)
        SD, //Memory shut down
        RSTB //Reset button
    );
    
    parameter SRAM_WIDTH = 64;
    parameter ADDR_WIDTH = 6; //Why is it 7 in the original code?
    
    input   CLK,SLP,CEB,SD,RSTB;
    input   [SRAM_WIDTH-1:0]    D;
    input   [ADDR_WIDTH-1:0]    A;
    input   WEB;
    
    task RESET_MEMORY;
        for(index = 0; index < SRAM_WIDTH; index = index + 1) begin
            sram_data[index] <= 0;
        end
    endtask
    
    reg [SRAM_WIDTH-1:0] sram_data[SRAM_WIDTH-1:0];
    reg in_shut_down = 1'b0;
    
    integer index; //Does this create a new register?
    
    output [SRAM_WIDTH-1:0] Q;
    
    assign Q = ~CEB & ~SD ? sram_data[A] : 0;
    
    initial begin
        RESET_MEMORY;
    end
    
    always@(posedge CLK) begin
    if (~SD & in_shut_down)
        in_shut_down <= 1'b0;
    if (~SD & ~SLP) begin
        if (WEB & ~CEB )
            sram_data[A] <= D;
        end
        if (RSTB) begin
            RESET_MEMORY;
        end
    else if (SD & ~in_shut_down) begin
            RESET_MEMORY;
            in_shut_down <= 1'b1;
        end
    end
    
    
    
endmodule
