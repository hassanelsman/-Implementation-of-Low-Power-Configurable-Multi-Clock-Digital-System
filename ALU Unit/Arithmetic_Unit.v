//module name and ports declarations
module Arithmetic_Unit #(parameter Width = 16)  (

input wire [1:0]		alu_fun,
input wire 				CLK,
input wire 				arith_enable,
input wire [Width-1:0]	A,B,
output reg 				carry_out,
output reg 				arith_flag,
output reg [Width-1:0]	arith_out	);

// internal signals definition
reg					arith_flag_comb;
reg [Width : 0]		arith_out_comb; //it has more bit to be the carry


//RTL Code

//combinational logic has perform the operations and outs flag and results and this should be stable for a time to store in the reg. at edge 
//test case if applied all i/p and disabled after edge.
always @ (*)

begin
 if (arith_enable)//enable is synchronous as if it is high for litle time it will not stop the unit
  begin
   arith_out_comb = 'b0 ;
   arith_flag_comb = 1'b1 ;
   case(alu_fun) //one mux o/p arith_out_comb i/ps is differen operations
   
   2'b00 : begin	// we dont need begin/end delete them later
			   arith_out_comb = A + B;
			  end
	2'b01 : begin
			   arith_out_comb = A - B;
			  end
	2'b10 : begin
			   arith_out_comb = A * B;
			  end
	2'b11 : begin
			   arith_out_comb = A / B;
			  end
	default : 	arith_out_comb = 'b0;
   endcase
   
  end

 else
  begin
   arith_out_comb = 'b0;
   arith_flag_comb = 1'b0 ;
  end
  
end  

//sequential logic
always @(posedge CLK)
begin
 arith_flag <= arith_flag_comb;
 arith_out  <= arith_out_comb [Width-1 : 0];
 carry_out  <= arith_out_comb [Width];
end 

endmodule




