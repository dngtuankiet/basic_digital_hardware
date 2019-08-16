`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2018 10:04:20 PM
// Design Name: Dang Tuan Kiet
// Module Name: ALU32bit
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


module ALU32bit(
    ALUControl,
    A,
    B,
    ALUResult,
    Zero,
    Negative,
    Overflow,
    CarryOut,
    clk
    );
    
    input [1:0] ALUControl;
    input [31:0] A, B;
    input clk;
    output reg [31:0] ALUResult;
    output reg Zero;
    output reg Overflow = 1'b0;
    output Negative, CarryOut;
    wire [32:0] tmp;
    wire [31:0] test;
    assign test[5:0] = A;
    always @(posedge clk)
    begin
        case(ALUControl)
        00: //ADD
            begin
                ALUResult <= A + B;
            end
        01: //XOR
            begin
                ALUResult <= A ^ B;
            end
        10: //SUB
            begin
                ALUResult <= A - B;
            end
        11: //SLT
           begin
            if(A[31] != B[31]) begin
                if(A[31] > B[31]) begin
                    ALUResult <= 1'b1;
                end
                else begin
                    ALUResult <= 1'b0;
                end
             end
             else begin
                if(A < B) 
                begin
                    ALUResult <= 1'b1;
                end
                else begin
                    ALUResult <= 1'b0;
                end
             end
          end
          endcase
    end
    
    always @(posedge clk) begin
        case(ALUControl)
        00: begin
            if((A[31] == 1'b0 && B[31] == 1'b0 && ALUResult[31] == 1'b1) || (A[31] == 1'b1 && B[31] == 1'b1 && ALUResult[31] == 1'b0)) begin
                Overflow <= 1'b1;
            end
        end
        01: begin
            if((A[31] == 1'b0 && B[31] == 1'b1 && ALUResult[31] == 1'b1) || (A[31] == 1'b1 && B[31] == 1'b0 && ALUResult[31] == 1'b0)) begin
                Overflow <= 1'b1;
            end
        end
        default: Overflow <= 1'b0;
        endcase
    end
    
    always @(ALUResult) begin
        if (ALUResult == 32'd0) begin
            Zero <= 1'b1;
        end
        else begin
            Zero <= 1'b0;
        end
    end
    
    assign Negative = ALUResult[31];
    assign tmp = {1'b0,A} + {1'b0,B};
    assign CarryOut = tmp[32];
    
    
endmodule
