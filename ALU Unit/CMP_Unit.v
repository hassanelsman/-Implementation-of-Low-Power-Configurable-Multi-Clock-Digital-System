//module name and ports declarations
module CMP_Unit #(parameter Width = 16) (

input wire [1:0]		alu_fun,
input wire 				CLK,
input wire 				cmp_enable,
input wire [Width-1:0]	A,B,
output reg 				cmp_flag,
output reg [Width-1:0]	cmp_out	);

// internal signals definition
reg					cmp_flag_comb;
reg [Width-1 : 0]		cmp_out_comb; 

//RTL Code

//combinational logic
always @ (*)
begin
 if (cmp_enable)
 begin
   cmp_flag_comb = 1'b1 ;
   case(alu_fun)
   
//	cmp_out_comb = 'b0 ;
	
	2'b00 : begin
			   cmp_out_comb ='d0;
			end
	2'b01 : begin
			   if (A==B)
			    cmp_out_comb = 'd1 ;
			   else
			    cmp_out_comb = 'd0 ;
			end
	2'b10 : begin
			   if (A>B)
			    cmp_out_comb = 'd2 ;
			   else
			    cmp_out_comb = 'd0 ;
			end
	2'b11 : begin
			   if (A<B)
			    cmp_out_comb = 'd3 ;
			   else
			    cmp_out_comb = 'd0 ;
			end
	default : 	cmp_out_comb = 'b0;
   endcase
   
  end

 else
  begin
   cmp_out_comb = 'b0;
   cmp_flag_comb = 1'b0 ;
  end
  
end  

//sequential logic
always @(posedge CLK)
begin
 cmp_flag <= cmp_flag_comb;
 cmp_out  <= cmp_out_comb;
end 

endmodule
