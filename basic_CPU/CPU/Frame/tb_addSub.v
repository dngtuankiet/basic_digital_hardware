module tb_addSub();
reg [15:0] A;
reg [15:0] B;
reg SEL;
wire [15:0] SUM;
wire Co;

//instantiate addSub

addSub_16bit addSub(.iA(A),
                    .iB(B),
                    .iSel(SEL),
                    .oS(SUM),
                    .oC(CO)
                    );
             
initial begin
A = 16'd0;
B = 16'd0;  
SEL = 1'b0;
#20// 5 + 3
A = 16'd5;
B = 16'd3;
SEL = 1'b0;
#20//129 + 372 = 501
A = 16'd129;
B = 16'd372;
SEL = 1'b0;
#20//109 - 25 = 84
A = 16'd109;
B = 16'd25;
SEL = 1'b1;
#20//898 - 421 = 477
A = 16'd898;
B = 16'd421;
SEL = 1'b1;
//OVERFLOW
#20//987 + 347 = 1334
A = 16'd987;
B = 16'd347;
SEL = 1'b0;
#20//320 - 347 = -27
A = 16'd320;
B = 16'd347;
SEL = 1'b0;
#20
$finish;
end

endmodule