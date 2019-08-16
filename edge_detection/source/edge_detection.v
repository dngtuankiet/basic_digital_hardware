`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2018 08:14:37 PM
// Design Name: 
// Module Name: edge_detection
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


module edge_detection(
    clk,
    rst,
    enable,
    enable_rise,
    enable_fall
    );
    input clk;
    input rst;
    input enable;
    output enable_rise;
    output enable_fall;
    
    wire clk;
    wire rst;
    wire enable;
    wire enable_rise;
    wire enable_fall;
    
    reg enable_late;
    
    //flipflop of enable_late
    always @(posedge clk) begin
        if(rst == 1'b0) begin
            enable_late <=1'b0;
        end
        else begin
            enable_late <= enable;
        end
    end
    
    assign enable_rise = enable & ~enable_late;
    assign enable_fall = ~enable & enable_late;
    
    
    
    
endmodule
