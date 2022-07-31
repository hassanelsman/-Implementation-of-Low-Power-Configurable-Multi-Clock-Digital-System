//module name and ports declarations
module Shift_Unit #(parameter Width = 16) (

input wire [1:0]		alu_fun,
input wire 				CLK,
input wire 				shift_enable,
input wire [Width-1:0]	A,B,
output reg 				shift_flag,
output reg [Width-1:0]	shift_out	);

// internal signals definition
reg					shift_flag_comb;
reg [Width- 1: 0]	shift_out_comb; 


//RTL Code
always @ (*)
begin
 if (shift_enable)
  begin
   shift_flag_comb = 1'b1 ;
   
   case(alu_fun)
//	shift_out_comb = 'b0 ;
	
	2'b00 :	shift_out_comb = A >> 1;
	2'b01 : shift_out_comb = A << 1;
	2'b10 : shift_out_comb = B >> 1;
	2'b11 :	shift_out_comb = B << 1;
	default : shift_out_comb = 'b0;
	
   endcase
   
  end

 else
  begin
   shift_out_comb = 'b0;
   shift_flag_comb = 1'b0 ;
  end
  
end  

//sequential logic
always @(posedge CLK)
begin
 shift_flag <= shift_flag_comb;
 shift_out  <= shift_out_comb;
end 

endmodule

