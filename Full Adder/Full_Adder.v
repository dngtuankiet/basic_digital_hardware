/*
Date: 15/05/2019
Name: Dang Tuan Kiet
Description: 1-bit Full_Adder
*/

module Full_Adder(i_bit0,
						i_bit1,
						i_carry,
						o_sum,
						o_carry
						);

input i_bit0;
input i_bit1;
input i_carry;
output o_sum;
output o_carry;

wire w1;
wire w2;
wire w3;

assign w1 = i_bit0 ^ i_bit1;
assign w2 = w1 & i_carry;
assign w3 = i_bit0 & i_bit1;

assign o_sum = w1 ^ i_carry;
assign o_carry = w2 | w3;

endmodule