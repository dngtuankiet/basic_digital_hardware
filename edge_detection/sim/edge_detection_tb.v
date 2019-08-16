`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2018 08:22:12 PM
// Design Name: 
// Module Name: edge_detection_tb
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


module edge_detection_tb();
    reg clk_tb;
    reg rst_tb;
    reg enable_tb;
    wire enable_rise_tb;
    wire enable_fall_tb;
    
    
    edge_detection E(
        .clk(clk_tb),
        .rst(rst_tb),
        .enable(enable_tb),
        .enable_rise(enable_rise_tb),
        .enable_fall(enable_fall_tb)
        );
    
    
    initial begin
    clk_tb = 0;
    rst_tb = 0;
    enable_tb = 0;
    forever begin
    #5 clk_tb = ~clk_tb;
    end
    end
    
    initial begin
    #22
    rst_tb = 1;
    #15
    enable_tb = 1;
    #40
    enable_tb = 0;
    #20
    $finish;
    end
    
    
    
    
    
    
    
    
    
endmodule
