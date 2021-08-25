/*
Date: 18/07/2019 
Name: Dang Tuan Kiet
Description: Multiplexer, R0-R7, Gout, DINout
*/

module Mux(iSel,
           iReg,
           iG,
           iDIN,
           oBus
           );

input iSel;
input iReg;
input iG;
input iDIN;
output oBus;

wire [9:0] iSel; //{DINout,Gout,R0-R7}
wire [127:0] iReg; //{R0-R7}
wire [15:0] iG;
wire [15:0] iDIN;
wire [15:0] oBus;

wire [15:0] R0;
wire [15:0] R1; 
wire [15:0] R2;
wire [15:0] R3; 
wire [15:0] R4; 
wire [15:0] R5;
wire [15:0] R6;
wire [15:0] R7;

wire [15:0] bus0;
wire [15:0] bus1;
wire [15:0] bus2;
wire [15:0] bus3;
wire [15:0] bus4;
wire [15:0] bus5;
wire [15:0] bus6;
wire [15:0] bus7;
wire [15:0] bus8;
wire [15:0] bus9;

assign {R7,R6,R5,R4,R3,R2,R1,R0} = iReg;

assign
bus0 = {R0[15] & iSel[0], R0[14] & iSel[0], R0[13] & iSel[0], R0[12] & iSel[0],
        R0[11] & iSel[0], R0[10] & iSel[0], R0[9]  & iSel[0], R0[8]  & iSel[0],
        R0[7]  & iSel[0], R0[6]  & iSel[0], R0[5]  & iSel[0], R0[4]  & iSel[0],
        R0[3]  & iSel[0], R0[2]  & iSel[0], R0[1]  & iSel[0], R0[0]  & iSel[0]},
      
bus1 = {R1[15] & iSel[1], R1[14] & iSel[1], R1[13] & iSel[1], R1[12] & iSel[1],
        R1[11] & iSel[1], R1[10] & iSel[1], R1[9]  & iSel[1], R1[8]  & iSel[1],
        R1[7]  & iSel[1], R1[6]  & iSel[1], R1[5]  & iSel[1], R1[4]  & iSel[1],
        R1[3]  & iSel[1], R1[2]  & iSel[1], R1[1]  & iSel[1], R1[0]  & iSel[1]},
        
bus2 = {R2[15] & iSel[2], R2[14] & iSel[2], R2[13] & iSel[2], R2[12] & iSel[2],
        R2[11] & iSel[2], R2[10] & iSel[2], R2[9]  & iSel[2], R2[8]  & iSel[2],
        R2[7]  & iSel[2], R2[6]  & iSel[2], R2[5]  & iSel[2], R2[4]  & iSel[2],
        R2[3]  & iSel[2], R2[2]  & iSel[2], R2[1]  & iSel[2], R2[0]  & iSel[2]},

bus3 = {R3[15] & iSel[3], R3[14] & iSel[3], R3[13] & iSel[3], R3[12] & iSel[3],
        R3[11] & iSel[3], R3[10] & iSel[3], R3[9]  & iSel[3], R3[8]  & iSel[3],
        R3[7]  & iSel[3], R3[6]  & iSel[3], R3[5]  & iSel[3], R3[4]  & iSel[3],
        R3[3]  & iSel[3], R3[2]  & iSel[3], R3[1]  & iSel[3], R3[0]  & iSel[3]},
        
bus4 = {R4[15] & iSel[4], R4[14] & iSel[4], R4[13] & iSel[4], R4[12] & iSel[4],
        R4[11] & iSel[4], R4[10] & iSel[4], R4[9]  & iSel[4], R4[8]  & iSel[4],
        R4[7]  & iSel[4], R4[6]  & iSel[4], R4[5]  & iSel[4], R4[4]  & iSel[4],
        R4[3]  & iSel[4], R4[2]  & iSel[4], R4[1]  & iSel[4], R4[0]  & iSel[4]},        
        
bus5 = {R5[15] & iSel[5], R5[14] & iSel[5], R5[13] & iSel[5], R5[12] & iSel[5],
        R5[11] & iSel[5], R5[10] & iSel[5], R5[9]  & iSel[5], R5[8]  & iSel[5],
        R5[7]  & iSel[5], R5[6]  & iSel[5], R5[5]  & iSel[5], R5[4]  & iSel[5],
        R5[3]  & iSel[5], R5[2]  & iSel[5], R5[1]  & iSel[5], R5[0]  & iSel[5]},        

bus6 = {R6[15] & iSel[6], R6[14] & iSel[6], R6[13] & iSel[6], R6[12] & iSel[6],
        R6[11] & iSel[6], R6[10] & iSel[6], R6[9]  & iSel[6], R6[8]  & iSel[6],
        R6[7]  & iSel[6], R6[6]  & iSel[6], R6[5]  & iSel[6], R6[4]  & iSel[6],
        R6[3]  & iSel[6], R6[2]  & iSel[6], R6[1]  & iSel[6], R6[0]  & iSel[6]},

bus7 = {R7[15] & iSel[7], R7[14] & iSel[7], R7[13] & iSel[7], R7[12] & iSel[7],
        R7[11] & iSel[7], R7[10] & iSel[7], R7[9]  & iSel[7], R7[8]  & iSel[7],
        R7[7]  & iSel[7], R7[6]  & iSel[7], R7[5]  & iSel[7], R7[4]  & iSel[7],
        R7[3]  & iSel[7], R7[2]  & iSel[7], R7[1]  & iSel[7], R7[0]  & iSel[7]},
        
bus8 = {iG[15] & iSel[8], iG[14] & iSel[8], iG[13] & iSel[8], iG[12] & iSel[8],
        iG[11] & iSel[8], iG[10] & iSel[8], iG[9]  & iSel[8], iG[8]  & iSel[8],
        iG[7]  & iSel[8], iG[6]  & iSel[8], iG[5]  & iSel[8], iG[4]  & iSel[8],
        iG[3]  & iSel[8], iG[2]  & iSel[8], iG[1]  & iSel[8], iG[0]  & iSel[8]},        
        
bus9 = {iDIN[15] & iSel[9], iDIN[14] & iSel[9], iDIN[13] & iSel[9], iDIN[12] & iSel[9],
        iDIN[11] & iSel[9], iDIN[10] & iSel[9], iDIN[9]  & iSel[9], iDIN[8]  & iSel[9],
        iDIN[7]  & iSel[9], iDIN[6]  & iSel[9], iDIN[5]  & iSel[9], iDIN[4]  & iSel[9],
        iDIN[3]  & iSel[9], iDIN[2]  & iSel[9], iDIN[1]  & iSel[9], iDIN[0]  & iSel[9]};
        
assign oBus = ((bus0 | bus1) | (bus2 | bus3)) | (((bus4 | bus5) | (bus6 | bus7)) | (bus8 | bus9));        
                      
endmodule
