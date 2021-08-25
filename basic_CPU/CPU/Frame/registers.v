/*
Date: 07/11/2019
Name: Dang Tuan Kiet
Description: 8 register R0 - R7
*/

module registers(iEnR0,
                 iEnR1,
                 iEnR2,
                 iEnR3,
                 iEnR4,
                 iEnR5,
                 iEnR6,
                 iEnR7,
                 iData,
                 iRst_n,
                 iClk,
                 oR0,
                 oR1,
                 oR2,
                 oR3,
                 oR4,
                 oR5,
                 oR6,
                 oR7
                 );
input iEnR0;
input iEnR1;
input iEnR2;
input iEnR3;
input iEnR4;
input iEnR5;
input iEnR6;
input iEnR7;
input iData;
input iRst_n;
input iClk;
output oR0;
output oR1;
output oR2;
output oR3;
output oR4;
output oR5;
output oR6;
output oR7;


wire iEnR0;
wire iEnR1;
wire iEnR2;
wire iEnR3;
wire iEnR4;
wire iEnR5;
wire iEnR6;
wire iEnR7;
wire [15:0] iData;
wire iRst_n;
wire iClk;
reg [15:0] oR0;
reg [15:0] oR1;
reg [15:0] oR2;
reg [15:0] oR3;
reg [15:0] oR4;
reg [15:0] oR5;
reg [15:0] oR6;
reg [15:0] oR7;

//R0
always @(posedge iClk) begin
  if(~iRst_n) begin
    oR0 <= 16'd0;
  end
  else begin
    if(iEnR0) begin
      oR0 <= iData;
    end
    else begin
      oR0 <= oR0;
    end
  end
end
//R1
always @(posedge iClk) begin
  if(~iRst_n) begin
    oR1 <= 16'd0;
  end
  else begin
    if(iEnR1) begin
      oR1 <= iData;
    end
    else begin
      oR1 <= oR1;
    end
  end
end
//R2
always @(posedge iClk) begin
  if(~iRst_n) begin
    oR2 <= 16'd0;
  end
  else begin
    if(iEnR2) begin
      oR2 <= iData;
    end
    else begin
      oR2 <= oR2;
    end
  end
end
//R3
always @(posedge iClk) begin
  if(~iRst_n) begin
    oR3 <= 16'd0;
  end
  else begin
    if(iEnR3) begin
      oR3 <= iData;
    end
    else begin
      oR3 <= oR3;
    end
  end
end
//R4
always @(posedge iClk) begin
  if(~iRst_n) begin
    oR4 <= 16'd0;
  end
  else begin
    if(iEnR4) begin
      oR4<= iData;
    end
    else begin
      oR4 <= oR4;
    end
  end
end
//R5
always @(posedge iClk) begin
  if(~iRst_n) begin
    oR5 <= 16'd0;
  end
  else begin
    if(iEnR5) begin
      oR5 <= iData;
    end
    else begin
      oR5 <= oR5;
    end
  end
end
//R6
always @(posedge iClk) begin
  if(~iRst_n) begin
    oR6 <= 16'd0;
  end
  else begin
    if(iEnR6) begin
      oR6 <= iData;
    end
    else begin
      oR6 <= oR6;
    end
  end
end
//R7
always @(posedge iClk) begin
  if(~iRst_n) begin
    oR7 <= 16'd0;
  end
  else begin
    if(iEnR7) begin
      oR7 <= iData;
    end
    else begin
      oR7 <= oR7;
    end
  end
end
                 
endmodule

