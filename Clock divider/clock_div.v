/*
Date: 05/09/2019
Name: Dang Tuan Kiet
Desciption: Module Clock Divider from 50MHz to 2Hz
*/
module clock_div(i_clk,
                 i_rst,
					       o_clk,
					       );
input i_clk;
input i_rst;
output o_clk;

wire time_up;
wire temp;
reg o_clk;
reg [23:0] counter;

//Counter flipflop
always @(posedge i_clk) begin
  if(~i_rst | time_up) begin
    counter <= 24'd0;
  end
  else begin 
		counter <= counter + 1'd1;
	end
end

//Output clock flipflop
always @(posedge i_clk) begin
  if(~i_rst) begin
      o_clk <= 1'b0;
  end
	else begin
	    o_clk <= temp;
	end
end

//time_up = (counter == 12499999)
assign time_up = ( ((counter[0]&counter[1])   & (counter[2] &counter[3]) )& 
				           ((counter[4]&counter[10])  & (counter[11]&counter[12])) )&				         
					       ( ((counter[13]&counter[15]) & (counter[17]&counter[18]))&
					         ((counter[19]&counter[20]) & (counter[21]&counter[23])) );

assign temp = time_up ^ o_clk;

endmodule
