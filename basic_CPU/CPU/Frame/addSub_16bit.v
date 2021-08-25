/*
Date: 17/07/2019
Name: Dang Tuan Kiet
Description: 16-bit adder-subtractor (without overflow detection)
*/

module addSub_16bit(iA,
                    iB,
                    iSel,
                    oS,
                    oC
                    );
input iA;
input iB;
input iSel;
output oS;
output oC;

wire [15:0] iA;
wire [15:0] iB;
wire iSel;
wire [15:0] oS;
wire oC;

wire [15:0] B;
wire [2:0] C;

//Instanciate 4 4-bit CLA adder

CLA_4bit bit3_0(.i_a(iA[3:0]),
                .i_b(B[3:0]),
                .i_ci(iSel),       //Sel = 0 => ADD, Sel = 1 => SUB
                .o_s(oS[3:0]),
                .o_co(C[0])
                );
                
CLA_4bit bit7_4(.i_a(iA[7:4]),
                .i_b(B[7:4]),
                .i_ci(C[0]),
                .o_s(oS[7:4]),
                .o_co(C[1])
                );
                
CLA_4bit bit11_8(.i_a(iA[11:8]),
                 .i_b(B[11:8]),
                 .i_ci(C[1]),
                 .o_s(oS[11:8]),
                 .o_co(C[2])
                 );
                 
CLA_4bit bit15_12(.i_a(iA[15:12]),
                  .i_b(B[15:12]),
                  .i_ci(C[2]),
                  .o_s(oS[15:12]),
                  .o_co(oC)
                  );
                  
//assign B = iB[] xor iC, 1's complement. Adding 1 to have 2's complement
assign
B[0] = iB[0] ^ iSel,
B[1] = iB[1] ^ iSel,
B[2] = iB[2] ^ iSel,
B[3] = iB[3] ^ iSel,
B[4] = iB[4] ^ iSel,
B[5] = iB[5] ^ iSel,
B[6] = iB[6] ^ iSel,
B[7] = iB[7] ^ iSel,
B[8] = iB[8] ^ iSel,
B[9] = iB[9] ^ iSel,
B[10] = iB[10] ^ iSel,
B[11] = iB[11] ^ iSel,
B[12] = iB[12] ^ iSel,
B[13] = iB[13] ^ iSel,
B[14] = iB[14] ^ iSel,
B[15] = iB[15] ^ iSel;

                    
endmodule
                  