`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2018 08:20:56 PM
// Design Name: 
// Module Name: testbench_2
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


module testbench_2();

    reg   [1:0]   ALUControl; // control bits for ALU operation
	reg   [31:0]  A, B;	    // inputs
	reg clk;
	wire [31:0]  ALUResult;	// answer
	wire Zero, Overflow;	    // Zero=1 if ALUResult == 0
	wire Negative, CarryOut;
	
	ALU32bit tb_2(
	   .ALUControl(ALUControl),
	   .A(A),
	   .B(B),
	   .clk(clk),
	   .ALUResult(ALUResult),
	   .Zero(Zero),
	   .Overflow(Overflow),
	   .Negative(Negative),
	   .CarryOut(CarryOut)
	   
	);
	always begin
	   #5; clk = ~clk;
	end
	initial begin
	   clk = 0;
       ALUControl = 2'b00;
       A = 32'd0;
       B = 32'd0;
    end
    initial begin 
        #30
       ALUControl = 2'b00;     
       A = 32'd6;
       B = 32'd0;
       #100;
//       ALUControl = 2'b10;
//       A = 32'h00000005;
//       B = 32'h00000002;      
       
       #1000;
       $finish;
    end

endmodule
