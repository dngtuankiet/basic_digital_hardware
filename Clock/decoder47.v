/*
Date: 11/05/2019
Name: Dang Tuan Kiet
Description: decoder BCD to 7-seg display
				 common anode 7-seg
*/
module decoder47(num,
					       out
					       );
input [3:0] num;
output [6:0] out;

reg [6:0] out; 
					  
always@(num) begin
	case(num)
		//0
		4'b0000: out = 7'b1000000;
		//1
		4'b0001: out = 7'b1111001;
		//2
		4'b0010: out = 7'b0100100;
		//3
		4'b0011: out = 7'b0110000;
		//4
		4'b0100: out = 7'b0000010;
		//5
		4'b0101: out = 7'b0010010;
		//6
		4'b0110: out = 7'b0000010;
		//7
		4'b0111: out = 7'b1111000;
		//8
		4'b1000: out = 7'b0000000;
		//9
		4'b1001: out = 7'b0011000;
		default: out = 7'b1111111;
	endcase
end

endmodule