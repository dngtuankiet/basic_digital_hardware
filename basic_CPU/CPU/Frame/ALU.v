/*
Date: 17/07/2019
Name: Dang Tuan Kiet
Description: 16-bit ALU
*/

module ALU(iA,
           iG,
           iAddSub,
           iClk,
           iRst_n,
           iRx,
           iRy,
           oResult
           );
input iA;
input iG;
input iAddSub;
input iClk;
input iRst_n;
input iRx;
input iRy;
output oResult;

wire iA;
wire iG;
wire iAddSub; //0 for ADD, 1 for SUB
wire iClk;
wire iRst_n;
wire [15:0] iRx;
wire [15:0] iRy;
reg [15:0] oResult;

reg [15:0] A;
wire [15:0] result;

//instantiate addSub

addSub_16bit addSub(.iA(A),
                    .iB(iRy),
                    .iSel(iAddSub),
                    .oC(),
                    .oS(result)
                    );

//register A and G
//A
always @(posedge iClk) begin 
  if(~iRst_n) begin
    A <= 16'd0;
  end
  else begin
    if(iA) begin
      A <= iRx;  
    end
    else begin
      A <= A;
    end
  end
end

//G
always @(posedge iClk) begin 
  if(~iRst_n) begin
    oResult <= 16'd0;
  end
  else begin
    if(iG) begin
      oResult <= result;  
    end
    else begin
      oResult <= oResult;
    end
  end
end

          
endmodule